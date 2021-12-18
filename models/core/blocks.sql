{{ config(materialized='incremental', unique_key='block_id', tags=['core']) }}

select 
    block_id,
    block_timestamp,
    header:hash::string as block_hash,
    header:parent_hash::string as block_parent_hash,
    header:gas_limit as gas_limit,
    header:gas_used as gas_used,
    header:miner::string as miner,
    header:size as size,
    tx_count
from {{ deduped_blocks("harmony_blocks") }}
-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
where {{ incremental_load_filter("block_timestamp") }}