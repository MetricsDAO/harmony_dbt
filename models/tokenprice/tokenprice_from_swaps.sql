{{
    config(
        materialized='table',
        unique_key="token_address||'-'||block_date",
        tags=['core', 'defi', 'tokenprice'],
        cluster_by=['block_date', 'token_address']
        )
}}

-- TODO: currently has duplicate volume - limit joins?
-- TODO: price discrepancy for 1ETH '0x6983d1e6def3690c4d616b13597a09e6193ea013' on Jan 24 - maybe more
--     suspected: 1USDC / AVAX pool: 0x422a9ff25a356525b8188c3c7074e0b0a345279d

with 
stables as (
  select * from {{ ref('harmony_stable_tokens')}}
),

-- trim the swaps table, truncate to day, and normalize the decimals
simpleswaps as (
  select
    date_trunc('day', s.block_timestamp) as block_date,
    s.tx_hash,
    s.token0_address,
    s.token0_symbol,
    s.token1_address,
    s.token1_symbol,
    (s.amount0in + s.amount0out) / pow(10, t0.decimals) as amt0,
    (s.amount1in + s.amount1out) / pow(10, t1.decimals) as amt1
  from {{ ref('swaps') }} as s
  left join {{ ref('tokens') }} as t0
    on t0.token_address = s.token0_address
  left join {{ ref('tokens') }} as t1
    on t1.token_address = s.token1_address
  where s.tx_hash not in ( -- remove gross mispriced swaps
    '0x45306aade61a002fff4bf42b68edb48addfb821c0f5d373201f3ab33b8d4abb4',
    '0x8c0b1638bf8f9e093b70d12faa5e639818e25902860fa1e0a6c422e6e3ccadfe'
  )
),

-- aggregate daily swap volumes between all pairs
swaps_daily_agg as (
  select  
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    s.token1_address,
    s.token1_symbol,
    sum(s.amt0) as amt0,
    sum(s.amt1) as amt1
  from simpleswaps as s
  group by 1,2,3,4,5
),

-- pull direct stable markets and calc the usd price
swaps_d0 as (
  select  
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from swaps_daily_agg as s
  inner join stables
    on s.token1_address = stables.token_address
  where s.token0_address not in (select token_address from stables)
  group by 1,2,3
),

-- pull direct stable markets and calc the usd price, from token1 to token0 (reversed)
swaps_r0 as (
  select  
    s.block_date,
    s.token1_address as token0_address,
    s.token1_symbol as token0_symbol,
    sum(amt1) as amt0,
    sum(amt0) as amt1,
    sum(amt0) / sum(amt1) as usd_price
  from swaps_daily_agg as s
  inner join stables
    on s.token0_address = stables.token_address
  where s.token1_address not in (select token_address from stables)
  group by 1,2,3
),

-- merge swaps d0 and r0
swaps_0 as (
  select
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from
    (
      select * from swaps_d0
      union all
      select * from swaps_r0
    ) as s
    group by 1,2,3
),

-- pull in the secondary markets - those that have a usd match in d0
swaps_d1 as (
  select 
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(s.amt0) as amt0,
    sum(s.amt1 * s0.usd_price) as amt1,
    sum(s.amt1 * s0.usd_price) / sum(s.amt0) as usd_price
    
  from swaps_daily_agg as s
  inner join swaps_0 s0
    on s.token1_address = s0.token0_address
        and s.block_date = s0.block_date
  where s.token0_address not in (select token_address from stables)
  group by 1,2,3
),

-- pull in the secondary markets from reverse swaps - those that have a usd match in r0
swaps_r1 as (
  select 
    s.block_date,
    s.token1_address,
    s.token1_symbol,
    sum(s.amt1) as amt0,
    sum(s.amt0 * s0.usd_price) as amt1,
    sum(s.amt0 * s0.usd_price) / sum(s.amt1) as usd_price
    
  from swaps_daily_agg as s
  inner join swaps_0 s0
    on s.token0_address = s0.token0_address
        and s.block_date = s0.block_date
  where s.token1_address not in (select token_address from stables)
  group by 1,2,3
),

-- merge swaps d1 and r1
swaps_1 as (
  select
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from
    (
      select * from swaps_d1
      union all
      select * from swaps_r1
    ) as s
    group by 1,2,3
),

-- pull d0 and d1 together, consolidating volume from both tables
swaps_d0_d1 as (
  select 
    block_date,
    token0_address,
    token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from 
    (select * from swaps_0
    union all
    select * from swaps_1) as t
  group by 1,2,3
),

-- pull in tertiary markets - those that only have swaps through d1
swaps_d2 as (
  select 
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(s.amt0) as amt0,
    sum(s.amt1 * sd0d1.usd_price) as amt1,
    sum(s.amt1 * sd0d1.usd_price) / sum(s.amt0) as usd_price
    
  from swaps_daily_agg as s
  inner join swaps_d1 sd1 -- filters only links through d1
    on s.token1_address = sd1.token0_address
        and s.block_date = sd1.block_date
  left join swaps_d0_d1 sd0d1 -- pricing lookups with combined markets
    on s.token1_address = sd0d1.token0_address
        and s.block_date = sd0d1.block_date
  where s.token0_address not in (select token_address from stables)
  group by 1,2,3
),

-- pull d0,d1,d2 together, aggregating swap volume between them
swaps_d0_d1_d2 as (
  select 
    block_date,
    token0_address,
    token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from 
    (select * from swaps_d0_d1
    union all
    select * from swaps_d2)
  group by 1,2,3
),

-- pull in 4th tier markets - those that only have links through d2 (TODO - see if this actually has any matches)
swaps_d3 as (
  select 
    s.block_date,
    s.token0_address,
    s.token0_symbol,
    sum(s.amt0) as amt0,
    sum(s.amt1 * sd0d1d2.usd_price) as amt1,
    sum(s.amt1 * sd0d1d2.usd_price) / sum(s.amt0) as usd_price
    
  from swaps_daily_agg as s
  inner join swaps_d2 sd2 -- filters only links through d1
    on s.token1_address = sd2.token0_address
        and s.block_date = sd2.block_date
  left join swaps_d0_d1_d2 sd0d1d2 -- pricing lookups with combined markets
    on s.token1_address = sd0d1d2.token0_address
        and s.block_date = sd0d1d2.block_date
  where s.token0_address not in (select token_address from stables)
  group by 1,2,3
),

swaps_d0_d1_d2_d3 as (
  select 
    block_date,
    token0_address,
    token0_symbol,
    sum(amt0) as amt0,
    sum(amt1) as amt1,
    sum(amt1) / sum(amt0) as usd_price
  from 
    (select * from swaps_d0_d1_d2
    union all
    select * from swaps_d3)
  group by 1,2,3
),

-- rename columns
allswaps as (
  select 
    block_date,
    token0_address as token_address,
    token0_symbol as token_symbol,
    amt0 as token_volume,
    amt1 as usd_volume,
    usd_price
  from swaps_d0_d1_d2_d3
),

-- stable tokens with a price of 1 USD to complete the pricing table (from token0 position)
usd_with_dates0 as (
  select 
    block_date,
    token0_address,
    token0_symbol,
    sum(s.amt0) as token_volume,
    sum(s.amt0) as usd_volume,
    min(1) as usd_price
  from swaps_daily_agg as s
  inner join stables 
    on s.token0_address = stables.token_address
  group by 1,2,3
),

-- stable tokens with a price of 1 USD to complete the pricing table (from token1 position)
usd_with_dates1 as (
  select 
    block_date,
    token1_address,
    token1_symbol,
    sum(s.amt1) as token_volume,
    sum(s.amt1) as usd_volume,
    min(1) as usd_price
  from swaps_daily_agg as s
  inner join stables 
    on s.token1_address = stables.token_address
  group by 1,2,3
),

-- combine stables volume tables
usd_with_dates_combined as (
  select 
    block_date,
    token0_address as token_address,
    token0_symbol as token_symbol,
    sum(token_volume) as token_volume,
    sum(token_volume) as usd_volume,
    min(1) as usd_price
  from 
    (
      select * from usd_with_dates0
      union all
      select * from usd_with_dates1
    )
  group by 1,2,3
),

-- combine pricing for all swaps with stable token volume
final as (
  select * from usd_with_dates_combined
  union all
  select * from allswaps
)

select * from final
