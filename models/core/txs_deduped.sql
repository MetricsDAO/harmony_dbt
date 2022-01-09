{{ 
    config(
        materialized='incremental',
        unique_key='tx_id',
        tags=['core'],
        cluster_by=['block_timestamp']
        )
}}

with dedupped_raw_txs as (

    select 
    *
    from {{ source("chainwalkers", "harmony_txs" ) }}
    where {{ incremental_load_filter("block_timestamp") }}
    qualify row_number() over (partition by tx_id order by ingested_at desc) = 1

)

select * from dedupped_raw_txs