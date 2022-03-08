{{
    config(
        materialized='incremental',
        unique_key="key",
        tags=['core', 'defi', 'tokenprice'],
        cluster_by=['block_date', 'token_address']
        )
}}

with 
stables as (
  select * from {{ ref('harmony_stable_tokens')}}
),

-- trim the swaps table, truncate to day, and normalize the decimals, remove nulls with inner join
simpleswaps as (
  select
    date_trunc('day', s.block_timestamp) as block_date,
    s.tx_hash,
    s.pool_address,
    s.token0_address,
    s.token0_symbol,
    s.token1_address,
    s.token1_symbol,
    (s.amount0in + s.amount0out) / pow(10, t0.decimals) as amt0,
    (s.amount1in + s.amount1out) / pow(10, t1.decimals) as amt1
  from {{ ref('swaps') }} as s
  inner join {{ ref('tokens') }} as t0
    on t0.token_address = s.token0_address
  inner join {{ ref('tokens') }} as t1
    on t1.token_address = s.token1_address
),

-- aggregate daily swap volumes between all pairs
swaps_daily_agg as (
  select  
    s.block_date,
    s.pool_address,
    s.token0_address,
    s.token0_symbol,
    s.token1_address,
    s.token1_symbol,
    sum(s.amt0) as amt0,
    sum(s.amt1) as amt1
  from simpleswaps as s
  --where s.block_date >= '2022-02-27' and s.block_date < '2022-03-02'
  group by 1,2,3,4,5,6
),


consolidated_pairs as (
  select 
    concat_ws( '-', block_date, token_address ) as key,
    block_date,
    token_address,
    token_symbol,
    sum(amt) as amt,
    pair_address,
    pair_symbol,
    sum(pair_amt) as pair_amt,
    sum(pair_amt) / sum (amt) as price,
    row_number() over (partition by block_date, token_address order by sum(amt) desc) as rank -- can't use rank() because of ties for 1st
  from (
    select 
        block_date, 
        token0_address as token_address, 
        token0_symbol as token_symbol,
        amt0 as amt,
        token1_address as pair_address,
        token1_symbol as pair_symbol,
        amt1 as pair_amt
    from swaps_daily_agg
    union all
    select 
        block_date, 
        token1_address as token_address, 
        token1_symbol as token_symbol,
        amt1 as amt,
        token0_address as pair_address,
        token0_symbol as pair_symbol,
        amt0 as pair_amt
    from swaps_daily_agg
   ) --1372
  group by 1,2,3,4,6,7
  order by 4,2,5 desc
),

start_stables as (
select distinct
    concat_ws( '-', c.block_date, c.token_address ) as key,
    c.block_date,
    s.token_address,
    s.token_symbol,
    1 as usd_price,
    0 as volume_for_price,
    null as price_pair_token,
    null as price_pair_symbol,
    'stables' as lookup_round
from consolidated_pairs as c
inner join stables as s
  on c.token_address = s.token_address
),

-- add WONE lookup
wone_lookup as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    sum(c.pair_amt) / sum(c.amt) as usd_price,
    sum(c.amt) as volume_for_price,
    null as price_pair_token,
    null as price_pair_symbol,
    'wONE' as lookup_round
from consolidated_pairs as c
  inner join start_stables as s
    on c.pair_address = s.token_address
where c.token_address = '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a' -- WONE  
group by 1,2,3,4,7,8
  
union all
  select * from start_stables
),

-- add lookups1a table for next round of matches, where top pair matches the wone_lookup table (wone + stables) (exclude keys that already exist in wone_lookup_table)
lookups1a as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    c.price * s.usd_price as usd_price,
    c.amt as volume_for_price,
    c.pair_address as pair_token_for_price,
    c.pair_symbol as pair_symbol_for_price,
    '1a' as lookup_round
from consolidated_pairs as c
  inner join wone_lookup as s
    on c.pair_address = s.token_address
    and c.block_date = s.block_date
    and c.rank = 1
where c.key not in (select key from wone_lookup)
  
union all
  select * from wone_lookup
), --112

-- add lookups1b table for next round of matches, where top pair matches the lookups1a table (exclude keys that already exist in lookups1a table)
lookups1b as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    c.price * s.usd_price as usd_price,
    c.amt as volume_for_price,
    c.pair_address as pair_token_for_price,
    c.pair_symbol as pair_symbol_for_price,
    '1b' as lookup_round
from consolidated_pairs as c
  inner join lookups1a as s
    on c.pair_address = s.token_address
    and c.block_date = s.block_date
    and c.rank = 1
where c.key not in (select key from lookups1a)
  
union all
  select * from lookups1a
), --274

-- add lookups1c table for next round of matches, where top pair matches the lookups1b table (exclude keys that already exist in lookups1b table)
lookups1c as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    c.price * s.usd_price as usd_price,
    c.amt as volume_for_price,
    c.pair_address as pair_token_for_price,
    c.pair_symbol as pair_symbol_for_price,
    '1c' as lookup_round
from consolidated_pairs as c
  inner join lookups1b as s
    on c.pair_address = s.token_address
    and c.block_date = s.block_date
    and c.rank = 1
where c.key not in (select key from lookups1b)
  
union all
  select * from lookups1b
), -- 276

-- add lookups2a table for next round of matches, where 2nd most common pair matches the lookups1c table (exclude keys that already exist in lookups1c table)
lookups2a as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    c.price * s.usd_price as usd_price,
    c.amt as volume_for_price,
    c.pair_address as pair_token_for_price,
    c.pair_symbol as pair_symbol_for_price,
    '2a' as lookup_round
from consolidated_pairs as c
  inner join lookups1c as s
    on c.pair_address = s.token_address
    and c.block_date = s.block_date
    and c.rank = 2
where c.key not in (select key from lookups1c)
  
union all
  select * from lookups1c
), -- 278

-- add lookups2b table for next round of matches, where 2nd most common pair matches the lookups2a table (exclude keys that already exist in lookups2a table)
lookups2b as (
select 
    c.key,  
    c.block_date,
    c.token_address,
    c.token_symbol,
    c.price * s.usd_price as usd_price,
    c.amt as volume_for_price,
    c.pair_address as pair_token_for_price,
    c.pair_symbol as pair_symbol_for_price,
    '2b' as lookup_round
from consolidated_pairs as c
  inner join lookups2a as s
    on c.pair_address = s.token_address
    and c.block_date = s.block_date
    and c.rank = 1
where c.key not in (select key from lookups2a)
  
union all
  select * from lookups2a
), -- 278

-- IF needed, additional lookup rounds could be added, e.g.:
-- TODO: add lookups2c table for next round of matches, where 2nd most common pair matches the lookups2b table (exclude keys that already exist in lookups2b table)
-- TODO: add lookups3a table for next round of matches, where 3rd most common pair matches the lookups2c table (exclude keys that already exist in lookups2c table)
-- TODO: add lookups3b table for next round of matches, where 3rd most common pair matches the lookups3a table (exclude keys that already exist in lookups3a table)
-- TODO: add lookups3c table for next round of matches, where 3rd most common pair matches the lookups3b table (exclude keys that already exist in lookups3b table)
-- TODO: remove date filter from swaps_daily_agg

final as (
select 
  l.block_date,
  l.token_address,
  l.token_symbol,
  l.usd_price,
  l.usd_price * sum(c.amt) as usd_volume,
  sum(c.amt) as token_volume,
  l.pair_token_for_price,
  l.pair_symbol_for_price,
  l.volume_for_price,
  l.key,
  l.lookup_round
from lookups2b as l
left join consolidated_pairs as c 
    on l.key = c.key
group by 1,2,3,4,7,8,9,10,11
order by l.token_symbol, l.block_date asc
)

-- the check see if any are missing from final (should be empty):
--select * from final 
--where key not in (select distinct key from consolidated_pairs);

--select * from final;  
--select distinct key from consolidated_pairs; 

select * from final