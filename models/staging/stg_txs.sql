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
    where 
        {% if is_incremental() %}
            ingested_at > ( select max(block_timestamp) from {{ this }} )
        {% else %}
            true
        {% endif %}
    qualify row_number() over (partition by tx_id order by ingested_at desc) = 1
)

select * from deduped_raw_txs
