{{ 
    config(
        materialized='incremental',
        unique_key='block_id',
        tags=['core'],
        cluster_by=['block_timestamp']
        )
}}

with

deduped_raw_blocks as (

    select 
        *
    from {{ source("chainwalkers","harmony_blocks") }}
    where {{ incremental_load_filter("ingested_at") }}
    qualify row_number() over (partition by block_id order by ingested_at desc) = 1

)

select * from deduped_raw_blocks
