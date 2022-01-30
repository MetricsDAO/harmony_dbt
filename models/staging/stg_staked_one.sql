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
        parsed_data:data:result:"circulating-supply"::float as circulating_supply,
        parsed_data:data:result:"epoch-last-block"::integer as epoch_last_block,
        parsed_data:data:result:"median-raw-stake"::float as median_raw_stake,
        parsed_data:data:result:"total-staking"::float as total_staking,
        parsed_data:data:result:"total-supply"::float as total_supply
    from source
    where parsed_data is not null
        and parsed_data:type = 'hmy_getStakingNetworkInfo'
)

select * from final