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
txs as (
    select
        *
    from {{ ref('txs') }}
    where {{ incremental_load_filter("block_timestamp") }}
),
create_potions as (
    select
        tx_hash,
        block_timestamp,
        from_address as crafter,
        concat('0x',substr(data,11+24,40)) as potion_type,
        java_hextoint(substr(data,11+64,64)) as potions_crafted
    from txs
    where to_address = '0x87cba8f998f902f2fff990effa1e261f35932e57' -- alchemist address
        and substr(data,0,10) = '0xa28beda3' -- create potion
)

select * from create_potions
