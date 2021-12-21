{{ config(materialized='incremental', unique_key='block_id', tags=['playground', 'small_blocks', 'small']) }}
select
    *
from harmony.dev.blocks q
where {{ incremental_load_filter("block_timestamp") }}