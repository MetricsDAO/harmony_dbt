{{ 
    config(
        materialized='incremental',
        unique_key='ingest_timestamp',
        incremental_strategy = 'delete+insert',
        tags=['core', 'ant_ingest'],
        cluster_by=['ingest_timestamp']
        )
}}

with
source_table as (

    select * from {{ ref("stg_ant_ingest") }}
    where {{ incremental_load_filter("ingest_timestamp") }}
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
