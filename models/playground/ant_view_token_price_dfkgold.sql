{{ 
    config(
        materialized='incremental',
        unique_key = 'timestamp',
        tags=['playground', 'ant_views', 'ant_tokens'],
        cluster_by=['timestamp']
    )
}}

WITH 
historical_prices as (
select
date_trunc('day',timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7' -- gold
group by 1
order by 1 desc
)
,RAW_LOGS as (
select 
  block_timestamp
, java_hextoint(substr(data,3,64)) as amount0In
, java_hextoint(substr(data,3+64,64)) as amount1In
, java_hextoint(substr(data,3+64+64,64)) as amount0Out
, java_hextoint(substr(data,3+64+64+64,64)) as amount1Out
from harmony.prod.logs
where topics[0] = '0xd78ad95fa46c994b6551d0da85fc275fe613ce37657fb8d5e3d130840159d822' -- Swap
and evm_contract_address = '0x321eafb0aed358966a90513290de99763946a54b' -- gold/jewel Pool
)
, daily_trades as (
  select 
  date_trunc('day', block_timestamp) as ddate
  ,sum(amount0In) as s0i
  ,sum(amount1In) as s1i
  ,sum(amount0Out) as s0o
  ,sum(amount1Out) as s1o
  from RAW_LOGS
  group by ddate
)
, daily_trades_prices as (
  select
  ddate as timestamp
  , 1/((s0i + s0o) / (s1i+s1o))*pow(10,-15)*j.price as price
  from daily_trades d
  LEFT JOIN harmony.dev.ant_view_token_price_jewel j on j.timestamp = d.ddate
)
, combine as (
    select 
    *
    from daily_trades_prices
  
    UNION ALL
    select 
    *
    from historical_prices
  
  
)
, final as (
    select 
    timestamp
    ,avg(price) as price
    from combine
    group by timestamp
)


select * from final
order by timestamp desc