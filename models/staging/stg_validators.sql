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

source as (
    select 
        ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from harmony.dev.ant_ingest
    where {{ incremental_load_filter("ingest_timestamp") }}
),

final as (
    select 
        ingest_timestamp,
        parsed_data:data:result as active_validators,
        array_size(parsed_data:data:result) as active_validators_count
    from source
    where parsed_data is not null
        and parsed_data:type = 'hmy_getAllValidatorAddresses'
)

select * from final