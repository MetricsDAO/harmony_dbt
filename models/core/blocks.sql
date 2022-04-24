{{
    config(
        materialized='incremental',
        unique_key='block_id',
        tags=['core'],
        cluster_by=['block_timestamp']
    )
}}

with base_blocks as (

    select * from {{ ref("stg_blocks") }}
    where {{ incremental_load_filter("ingested_at") }}
),

final as (

    select
        block_id,
        block_timestamp,
        ingested_at,
        header:hash::string as block_hash,
        header:parent_hash::string as block_parent_hash,
        header:gas_limit as gas_limit,
        header:gas_used as gas_used,
        header:miner::string as miner,
        header:nonce::string as nonce,
        header:size as size,
        tx_count,
        header:state_root::string as state_root,
        header:receipts_root::string as receipts_root

    from base_blocks
)

select * from final
