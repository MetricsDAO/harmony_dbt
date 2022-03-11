{{ 
    config(
        materialized='incremental',
        unique_key='day_date || validator_address',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['day_date']
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


subselect_source as (
    select
        ingest_timestamp,
        parsed_data:data:result as actual_data
    from source_table
    where parsed_data:type = 'hmy_getAllValidatorInformation'
        and parsed_data:data:result[0] is not null
),

flattened_validators as (
    select
        ingest_timestamp,
        date_trunc('day', ingest_timestamp) as day_date,
        f.value:validator:address::string as validator_address, -- TODO: - convert to 0x
        f.value:validator:identity::string as validator_identity, -- random name that people used
        f.value:"active-status"::string as active_status,
        f.value:"booted-status"::string as booted_status,
        f.value:validator:delegations as delegations,
        f.value:"total-delegation"::float as total_delegation,
        array_size(f.value:validator:delegations) as total_delegator_count
    from subselect_source, Table(Flatten(subselect_source.actual_data)) as f
)

select
    *
from flattened_validators
