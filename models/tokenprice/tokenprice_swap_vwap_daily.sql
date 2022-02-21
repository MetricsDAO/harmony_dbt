{{
    config(
        materialized='incremental',
        unique_key="block_date||'-'||token_address",
        incremental_strategy = 'delete+insert',
        tags=['core', 'swaps', 'defi','tokenprice'],
        cluster_by=['block_date', 'token_address']
        )
}}

with

-- Assuming these stables have USD value of 1
stables as (
    select 
        token_address,
        token_symbol,
        decimals
    from tokens 
    where token_symbol in  ('1USDC', '1USDT', '1DAI', 'UST', 'BUSD')
),

swaps1 as (
    select 
        log_id,
        block_timestamp,
        date_trunc('day',block_timestamp) as block_date,
        tx_hash,
        token0_address as token_address,
        token0_symbol as token_symbol,
        (amount0In + amount0Out) as token_amount_raw,
        tokens.decimals as token_decimals,
        ((amount0In + amount0Out) / pow(10, tokens.decimals)) as token_amount_norm,
        (amount1In + amount1Out) as stable_amount_raw,
        stables.decimals as stable_decimals,
        ((amount1In + amount1Out) / pow(10, stables.decimals)) as stable_amount_norm
    from swaps
    inner join stables
        on swaps.token1_address = stables.token_address
    inner join tokens
        on swaps.token0_address = tokens.token_address
),

swaps2 as (
    select 
        log_id,
        block_timestamp,
        date_trunc('day',block_timestamp) as block_date,
        tx_hash,
        token1_address as token_address,
        token1_symbol as token_symbol,
        (amount1In + amount1Out) as token_amount_raw,
        tokens.decimals as token_decimals,
        ((amount1In + amount1Out) / pow(10, tokens.decimals)) as token_amount_norm,
        (amount0In + amount0Out) as stable_amount_raw,
        stables.decimals as stable_decimals,
        ((amount0In + amount0Out) / pow(10, stables.decimals)) as stable_amount_norm
    from swaps
    inner join stables
        on swaps.token0_address = stables.token_address
    inner join tokens
        on swaps.token1_address = tokens.token_address
),

bothswaps as (
    select * from swaps1
    union all
    select * from swaps2
),

final as (
    select
        block_date, 
        token_address, 
        token_symbol, 
        (sum(stable_amount_norm) / sum(token_amount_norm)) as usd_price, 
        sum(stable_amount_norm) as usd_24h_volume
    from bothswaps
    group by 1,2,3
    order by block_date
)

select * from final 
