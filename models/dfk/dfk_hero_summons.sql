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
        block_timestamp,
        tx_hash,
        substr(data,11) as crystal_id
    from txs
    where 1=1
        and (to_address = '0x65dea93f7b886c33a78c10343267dd39727778c2' or to_address = '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355')
        and substr(data,0,10) = '0x690e7c09'
),

generation as (
    select 
        tx_hash,
        event_inputs:tokenId as hero_id
    from logs
    where tx_hash in (select tx_hash from crystal_to_hero_summons)
        and event_name = 'Transfer'
),

final as (
    select 
        g.tx_hash,
        hero_id,
        concat('0x',crystal_id) as crystal_id,
        s.block_timestamp
    from generation g
    left join crystal_to_hero_summons s on s.tx_hash = g.tx_hash
)

select * from final