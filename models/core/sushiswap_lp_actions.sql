{{
    config(
        materialized='incremental',
        unique_key='log_id',
        tags=['core', 'sushiswap_lp_actions'],
        cluster_by=['log_id']
        )
}}


with 

logs as (
    select
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

events as (
    select 
        log_id,
        block_timestamp,
        ingested_at,
        date_trunc('day', block_timestamp) as block_date,
        tx_hash,
        event_index,
        native_contract_address,
        evm_contract_address,
        case 
            when event_name='Mint' 
                then 'ADD_LIQUIDITY'
            else 'REMOVE_LIQUIDITY'
        end as action,
        event_inputs:amount0::int as amount0_raw,
        event_inputs:amount1::int as amount1_raw
    from logs
    where ( event_name='Mint' or event_name='Burn' )
        and event_inputs:sender = '0x1b02da8cb0d097eb8d57a175b88c7d8b47997506'
),

txs as (
    select
        tx_hash,
        from_address
    from {{ ref('txs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

liquidity_pools as (
    select
        *
    from {{ ref('liquidity_pools') }}
),

tokenprices as (
    select
        *
    from {{ ref('tokenprices') }}
),

tokens as (
    select
        *
    from {{ ref('tokens') }}
),

events_liquidity_pools as (
    select 
        events.log_id,
        events.block_timestamp,
        events.block_date,
        events.tx_hash,
        liquidity_pools.*,
        events.action,
        events.amount0_raw,
        events.amount1_raw
    from events
    join liquidity_pools 
        on events.evm_contract_address=liquidity_pools.pool_address
),

token_prices_usd as (
    select 
        tokenprices.block_date,
        tokenprices.token_address,
        tokenprices.token_symbol,
        tokens.decimals,
        tokenprices.usd_price
    from tokenprices
    join tokens 
        on tokenprices.token_address=tokens.token_address
),

final_table as (
    select
        events_liquidity_pools.log_id,
        events_liquidity_pools.block_timestamp,
        events_liquidity_pools.tx_hash,
        txs.from_address as liquidity_provider,
        events_liquidity_pools.pool_address,
        events_liquidity_pools.pool_name,
        events_liquidity_pools.token0,
        token0_prices_usd.token_symbol as token0_name,
        events_liquidity_pools.token1,
        token1_prices_usd.token_symbol as token1_name,
        events_liquidity_pools.action,
        events_liquidity_pools.amount0_raw/pow(10, token0_prices_usd.decimals) 
            as amount0_adjusted,
        events_liquidity_pools.amount1_raw/pow(10, token1_prices_usd.decimals) 
            as amount1_adjusted,
        events_liquidity_pools.amount0_raw/pow(10, token0_prices_usd.decimals)*token0_prices_usd.usd_price
            as amount0_usd,
        events_liquidity_pools.amount1_raw/pow(10, token1_prices_usd.decimals)*token1_prices_usd.usd_price 
            as amount1_usd
    from events_liquidity_pools
        join txs 
            on events_liquidity_pools.tx_hash=txs.tx_hash
        left join token_prices_usd as token0_prices_usd
            on events_liquidity_pools.token0=token0_prices_usd.token_address 
                and events_liquidity_pools.block_date=token0_prices_usd.block_date
        left join token_prices_usd as token1_prices_usd
            on events_liquidity_pools.token1=token1_prices_usd.token_address 
                and events_liquidity_pools.block_date=token1_prices_usd.block_date
    order by events_liquidity_pools.block_timestamp desc
)

select * from final_table 
