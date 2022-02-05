{{ 
    config(
        materialized='incremental',
        unique_key='day_date',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['day_date']
        )
}}

with

ingest_data as (
    select
        ingest_timestamp::timestamp as ingest_timestamp,
        try_parse_json(ingest_data) as parsed_object
    from harmony.dev.ant_ingest
    where {{ incremental_last_x_days("ingest_timestamp", 2) }}
),

parsed_injest as (
    select
        *
    from ingest_data
    where parsed_object:type = 'tranquil_ingest'
),

final as (
    select
        date_trunc('day',ingest_timestamp) as day_date,
        avg(parsed_object:data::float) as tranq_tvl
    from parsed_injest
    group by 1
)

select * from final
