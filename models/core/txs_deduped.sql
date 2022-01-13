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
    from {{ deduped_txs("harmony_txs") }}
    where {{ incremental_load_filter("block_timestamp") }}

)

select * from deduped_raw_txs
