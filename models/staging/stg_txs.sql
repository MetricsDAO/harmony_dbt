{{
    config(
        materialized='incremental',
        unique_key='tx_id',
        tags=['core', 'transactions'],
        cluster_by=['block_timestamp']
        )
}}

with

deduped_raw_txs as (
    select
        *
    from {{ source("chainwalkers", "harmony_txs") }}
    where {{ incremental_load_filter("ingested_at") }}
    qualify row_number() over (partition by tx_id order by ingested_at desc) = 1
)

select * from deduped_raw_txs
