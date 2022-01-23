{{ 
    config(
        materialized='incremental',
        unique_key = 'timestamp',
        incremental_strategy = 'delete+insert',
        tags=['tokenprice'],
        cluster_by=['timestamp']
    )
}}

with

historical_prices as (
    select
        date_trunc('day',timestamp) as timestamp,
        avg(price) as price
    from harmony.dev.ant_token_prices
    where token_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f' -- JEWEL
    group by 1
    order by 1 desc
),

raw_logs as (
    select 
        block_timestamp,
        java_hextoint(substr(data,3+64*0,64)) as amount0In,
        java_hextoint(substr(data,3+64*1,64)) as amount1In,
        java_hextoint(substr(data,3+64*2,64)) as amount0Out,
        java_hextoint(substr(data,3+64*3,64)) as amount1Out
    from {{ ref('logs') }}
    where topics[0] = '0xd78ad95fa46c994b6551d0da85fc275fe613ce37657fb8d5e3d130840159d822' -- Swap
    and evm_contract_address = '0xa1221a5bbea699f507cc00bdedea05b5d2e32eba' -- JEWEL / 1USDC Pool
),

daily_trades as (
    select 
        date_trunc('day', block_timestamp) as ddate,
        sum(amount0In) as s0i,
        sum(amount1In) as s1i,
        sum(amount0Out) as s0o,
        sum(amount1Out) as s1o
    from raw_logs
    group by 1
),

daily_trades_prices as (
    select
        ddate as timestamp,
        1 / ( (s0i + s0o) / (s1i+s1o) ) * pow(10,12) as price
    from daily_trades d
),

combine as (
    select 
        *
    from daily_trades_prices
  
    union all

    select 
        *
    from historical_prices
),

final as (
    select 
        timestamp,
        avg(price) as price
    from combine
    group by 1
)

select * from final