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

create_potions as (
    select
        block_timestamp,
        tx_hash,
        from_address as crafter,
        concat('0x',substr(data,11+24,40)) as potion_type,
        java_hextoint(substr(data,11+64,64)) as potions_crafted
    from {{ ref('txs') }}
    where to_address = '0x87cba8f998f902f2fff990effa1e261f35932e57'
        and substr(data,0,10) = '0xa28beda3'
)

select * from create_potions