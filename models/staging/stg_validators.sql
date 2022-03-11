{{ 
    config(
        materialized='incremental',
        unique_key='ingest_timestamp',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['ingest_timestamp']
        )
}}

with
old_source_table as (

    select
        ingest_timestamp::timestamp as ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from {{ source("ingest","src_old_ant_ingest") }}
    where {{ incremental_load_filter("ingest_timestamp") }}
        and ingest_timestamp < '2022-03-07 15:00:00.000'

),
current_source_table as (

    select
        ingest_timestamp::timestamp as ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from {{ source("ingest","ant_ingest") }}
    where {{ incremental_load_filter("ingest_timestamp") }}
        and ingest_timestamp > '2022-03-07 15:00:00.000'

),
source_table as (

    select * from old_source_table
    union all 
    select * from current_source_table

),

final as (
    select 
        ingest_timestamp,
        parsed_data:data:result as active_validators,
        array_size(parsed_data:data:result) as active_validators_count
    from source_table
    where parsed_data is not null
        and parsed_data:type = 'hmy_getAllValidatorAddresses'
)

select * from final
