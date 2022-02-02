{{ 
    config(
        materialized='table',
        tags=['metrics'],
        cluster_by=['evm_contract_address']
    )
}}

with 
lp_interested as (
    select
        pool_address,
        pool_name,
        token0,
        token1
    from {{ ref("dfk_dex_lp_labels") }}
),
tokens_interested as (
    select
        token_address,
        token_name,
        token_symbol,
        decimals
    from {{ ref("dfk_tokens") }}
),
all_sync as (
    select
        evm_contract_address,
        block_timestamp,
        block_id,
        event_inputs,
        event_name,
        java_hextoint(substr(event_index,3))::integer as event_index_int,
        dateadd('milliseconds', event_index_int, block_timestamp) as tiebreaker
    from {{ ref("logs") }}
    where event_name = 'Sync'
        and evm_contract_address in (select pool_address from lp_interested)
),
latest_sync as (
    select
        evm_contract_address,
        max(tiebreaker) as tiebreaker_join
    from all_sync
    group by 1
),
final as (
    select 
        s.evm_contract_address as evm_contract_address,
        s.block_timestamp as block_timestamp,
        s.block_id as block_id,
        s.event_inputs:reserve0::integer as token0_count_raw,
        s.event_inputs:reserve1::integer as token1_count_raw,
        div0(token0_count_raw , pow(10, t0.decimals)) as token0_count,
        div0(token1_count_raw , pow(10, t1.decimals)) as token1_count,
        pool_name,
        token0,
        token1
    from latest_sync as l
    left join all_sync as s 
        on l.evm_contract_address = s.evm_contract_address 
        and s.tiebreaker = l.tiebreaker_join
    left join lp_interested
        on l.evm_contract_address = pool_address
    left join tokens_interested as t0
        on t0.token_address = token0
    left join tokens_interested as t1
        on t1.token_address = token1
 )

select * from final 
