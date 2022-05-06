{{
    config(
        materialized = 'incremental',
        unique_key = 'log_id',
        tags = ['models', 'viperswap', 'viperswap_lp_actions'],
        cluster_by = ['block_timestamp']
    )
}}

with

logs as (
    select
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

txs as (
    select
        *
    from {{ ref('txs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

liquidity_pools as (
    select
        *
    from {{ ref('liquidity_pools') }}
),

tokens as (
    select
        token_address,
        token_name,
        decimals
    from {{ ref('tokens') }}
),

prices as (
    select
        block_date,
        token_address,
        token_symbol,
        usd_price
    from {{ ref('tokenprices') }}
),

liquidity_events as (
    select
        log_id,
        block_id,
        block_timestamp,
        ingested_at,
        tx_hash,
        evm_contract_address AS pool_address,

        case
            when event_name = 'Burn' then 'remove_liquidity'
            when event_name = 'Mint' then 'add_liquidity'
            else 'NA'
        end as action,

        event_inputs:amount0::INT AS amount0_raw,
        event_inputs:amount1::INT AS amount1_raw
    from logs
    where (event_name = 'Burn'
        OR event_name = 'Mint')
        AND event_inputs:sender = '0xf012702a5f0e54015362cbca26a26fc90aa832a3' -- ViperSwap's UniswapV2Router02 forked contract
),

liquidity_tokens as (
    select
        tx_hash,
        substring(data, 1, 10),
        concat('0x', substring(data, 35, 40)) as token0,
        --0xf305d719 - function signature for addLiquidityETH
        --0x02751cec - function signature for removeLiquidityETH
        --0xcf664087a5bb0237a0bad6742852ec6c8d69a27a - WONE token
        case
            when substring(data, 1, 10) = '0xf305d719' then '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a'
            when substring(data, 1, 10) = '0x02751cec' then '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a'
        else concat('0x', substring(data, 99, 40))
        end as token1
    from txs
    where substring(data, 1, 10) in ('0xf305d719', -- function signature for addLiquidityETH; token1 is WONE
                                 '0xe8e33700', -- function signature for addLiquidity
                                 '0x02751cec', -- function signature for removeLiquidityETH; token1 is WONE
                                 '0xbaa2abde') -- function signature for removeLiquidity
),

liquidity_providers as (
    select
        tx_hash,
        from_address as liquidity_provider
    from txs
),

liquidity_events_pools as (
    select
        events.log_id,
        events.block_id,
        events.block_timestamp,
        events.ingested_at,
        events.tx_hash,
        events.action,
        events.pool_address,
        pools.pool_name,
        liquidity_tokens.token0,
        liquidity_tokens.token1,
        events.amount0_raw,
        events.amount1_raw
    from liquidity_events as events
    left join liquidity_tokens
        on events.tx_hash = liquidity_tokens.tx_hash
    left join liquidity_pools as pools
        on events.pool_address = pools.pool_address
),

token_prices_usd as (
    select
        prices.block_date AS date,
        prices.token_address,
        prices.token_symbol,
        tokens.token_name,
        tokens.decimals,
        prices.usd_price
    from tokens 
    left join prices
        on tokens.token_address = prices.token_address
),

final as (
    select
        events_pools.log_id,
        events_pools.block_id,
        events_pools.block_timestamp,
        events_pools.ingested_at,
        events_pools.tx_hash,
        providers.liquidity_provider,
        events_pools.action,
        events_pools.pool_address,
        events_pools.pool_name,
        events_pools.token0,
        prices_0.token_symbol as token0_symbol,
        prices_0.token_name as token0_name,
        events_pools.token1,
        prices_1.token_symbol as token1_symbol,
        prices_1.token_name as token1_name,
        events_pools.amount0_raw,
        events_pools.amount0_raw / pow(10, prices_0.decimals) as amount0_adjusted,
        events_pools.amount1_raw,
        events_pools.amount1_raw / pow(10, prices_1.decimals) as amount1_adjusted,
        events_pools.amount0_raw / pow(10, prices_0.decimals) * prices_0.usd_price as amount0_usd,
        events_pools.amount1_raw / pow(10, prices_1.decimals) * prices_1.usd_price as amount1_usd
    from liquidity_events_pools as events_pools
    left join liquidity_providers as providers
        on events_pools.tx_hash = providers.tx_hash
    left join token_prices_usd as prices_0
        on events_pools.token0 = prices_0.token_address
        and date_trunc('day', events_pools.block_timestamp) = prices_0.date
    left join token_prices_usd AS prices_1
        on events_pools.token1 = prices_1.token_address
        and date_trunc('day', events_pools.block_timestamp) = prices_1.date
)

select * from final
