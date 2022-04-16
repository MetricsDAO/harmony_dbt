{{
    config(
        materialized='incremental',
        unique_key='log_id',
        tags=['dfk', 'dfk_seed_liquidity_actions'],
        cluster_by=['log_id']
        )
}}

with 

logs as (
    select * 
    from {{ ref('logs') }}
    where {{ incremental_load_filter("block_timestamp") }}
),

liquidity_pools as (
    select * 
    from {{ ref('liquidity_pools') }}
),

tokens as (
    select * 
    from {{ ref('tokens') }}
),

txs as (
    select 
        tx_hash 
    from {{ ref('txs') }}
    where {{ incremental_load_filter("block_timestamp") }}
        and to_address = '0x24ad62502d1c652cc7684081169d04896ac20f30'
        and substr(data,0,10) 
            in ('0x02751cec','0xf305d719','0xbaa2abde','0xe8e33700')
),

main_table as (
    select
        logs.log_id
        ,logs.block_id
        ,logs.block_timestamp
        ,logs.tx_hash
        ,logs.event_inputs:amount0 / pow(10, t0.decimals) 
            as amount_0
        ,logs.event_inputs:amount1 / pow(10, t1.decimals)
            as amount_1
        ,logs.native_contract_address 
            as one_lp_address
        ,logs.evm_contract_address 
            as eth_lp_address
        ,liquidity_pools.pool_name
        ,liquidity_pools.token0 
            as token0_address
        ,liquidity_pools.token1 
            as token1_address
        ,t0.token_name 
            as token0_name
        ,t1.token_name 
            as token1_name
        ,case
            when event_name = 'Mint' 
                then 'ADD_LIQUIDITY' 
            when event_name = 'Burn' 
                then 'REMOVE_LIQUIDITY'
            end as action
    from logs
        left join liquidity_pools 
            on logs.evm_contract_address = liquidity_pools.pool_address
        left join tokens t0 
            on liquidity_pools.token0 = t0.token_address
        left join tokens t1 
            on liquidity_pools.token1 = t1.token_address
    where 1=1
        and tx_hash in (select tx_hash from txs)
        and (event_name = 'Mint' 
             or event_name = 'Burn')
)

select * from main_table
