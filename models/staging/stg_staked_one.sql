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
        parsed_data:data:result:"circulating-supply"::float as circulating_supply,
        parsed_data:data:result:"epoch-last-block"::integer as epoch_last_block,
        parsed_data:data:result:"median-raw-stake"::float as median_raw_stake,
        parsed_data:data:result:"total-staking"::float as total_staking,
        parsed_data:data:result:"total-supply"::float as total_supply
    from source_table
    where parsed_data is not null
        and parsed_data:type = 'hmy_getStakingNetworkInfo'
)

select * from final