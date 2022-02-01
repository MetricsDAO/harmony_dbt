{{ 
    config(
        materialized='incremental',
        unique_key='day_date || validator_address',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['day_date']
        )
}}

with source_table as 
(
    select
        ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from harmony.dev.ant_ingest
    where {{ incremental_load_filter("ingest_timestamp") }}
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
        date_trunc('day', ingest_timestamp) as day_date,
        f.value:validator:address as validator_address, -- TODO: - convert to 0x
        f.value:validator:identity as validator_identity, -- random name that people used
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

