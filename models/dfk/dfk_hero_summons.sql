{{ 
    config(
        materialized='incremental',
        unique_key='tx_hash',
        incremental_strategy = 'delete+insert',
        tags=['dfk'],
        cluster_by=['block_timestamp']
        ) 
}}

with

logs as (
    select
        *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("block_timestamp") }}
),

txs as (
    select
        *
    from {{ ref("txs") }}
    where {{ incremental_load_filter("block_timestamp") }}
),

crystal_to_hero_summons as (
    select  
        txs.block_timestamp,
        txs.tx_hash,
        substr(txs.data,11) as crystal_id,
        txs.from_address as summoneer,
        logs.event_inputs:tokenId as hero_id
    from txs
    left join logs on txs.tx_hash = logs.tx_hash and logs.event_name = 'Transfer'
    where substr(txs.data,0,10) = '0x690e7c09' -- open
        and status = TRUE
        and (
                txs.to_address = '0x65dea93f7b886c33a78c10343267dd39727778c2' -- Summoning Contract
                or txs.to_address = '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355' -- Summoning Contract 2
            )
),
final as (
    select 
        tx_hash,
        hero_id,
        concat('0x',crystal_id) as crystal_id,
        block_timestamp,
        summoneer
    from crystal_to_hero_summons s
)

select * from final
