{{ 
    config(
        materialized='incremental',
        unique_key='ingest_timestamp',
        incremental_strategy = 'delete+insert',
        tags=['core','ingest'],
        cluster_by=['ingest_timestamp']
        )
}}

with
old_source_table as (

    select
        ingest_timestamp::timestamp as ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from {{ source("ingest","src_old_ant_ingest") }}
    where     
        {% if is_incremental() %}
            ingest_timestamp::timestamp > (select max(ingest_timestamp) from {{ this }})
        {%- else -%}
            true
        {% endif %}
        and ingest_timestamp < '2022-03-07 15:00:00.000'

),
current_source_table as (

    select
        ingest_timestamp::timestamp as ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from {{ source("ingest","ant_ingest") }}
    where         
        {% if is_incremental() %}
            ingest_timestamp::timestamp > (select max(ingest_timestamp) from {{ this }})
        {%- else -%}
            true
        {% endif %}
        and ingest_timestamp > '2022-03-07 15:00:00.000'

),
source_table as (

    select * from old_source_table
    union all 
    select * from current_source_table

)

select * from source_table
