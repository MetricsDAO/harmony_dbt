{{ 
    config(
        materialized='incremental',
        unique_key='ukey',
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

subselect_source as (
    select 
        parsed_data,
        ingest_timestamp
    from source_table
    where parsed_data:type = 'hmy_call'
        and parsed_data:subtype = 'hmy20_totalSupply'
        and parsed_data:data:result is not null
        and len(parsed_data:data:result) > 4
),

final as (
  select
        concat_ws('-', ingest_timestamp, t.token_name) as ukey,
        ingest_timestamp::timestamp as ingest_timestamp,
        java_hextoint(substr(parsed_data:data:result,3)) as supply,
        parsed_data:token as token_address,
        t.token_name,
        date_trunc('day',ingest_timestamp::timestamp) as day_date
    from subselect_source
    left join harmony.dev.tokens t
        on t.token_address = parsed_data:token
)
  
select * from final
 