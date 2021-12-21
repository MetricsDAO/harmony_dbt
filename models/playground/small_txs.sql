{{ config(materialized='incremental', unique_key='tx_id', tags=['playground', 'small_txs', 'small']) }}
select
    *
from harmony.dev.txs q
where {{ incremental_load_filter("block_timestamp") }}