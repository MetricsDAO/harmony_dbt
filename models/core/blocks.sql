{{ config(materialized='table', tags=['core']) }}

SELECT 
    block_id,
    block_timestamp,
    header:hash::string as block_hash,
    header:parent_hash::string as block_parent_hash,
    header:gas_limit as gas_limit,
    header:gas_used as gas_used,
    header:miner::string as miner,
    header:size as size,
    tx_count
FROM {{ chainwalkers_latest("harmony_blocks") }}
