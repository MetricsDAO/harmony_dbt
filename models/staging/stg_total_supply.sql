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
ingest_source as (
    select
        try_parse_json(ingest_data) as parsed_data,
        ingest_timestamp
  from harmony.dev.ant_ingest
  where {{ incremental_load_filter("ingest_timestamp") }}
),

subselect_source as (
    select 
        parsed_data,
        ingest_timestamp
    from ingest_source
    where parsed_data:type = 'hmy_call'
        and parsed_data:subtype = 'hmy20_totalSupply'
        and parsed_data:data:result is not null
        and len(parsed_data:data:result) > 4
),

final as (
  select
        concat_ws('-', ingest_timestamp, t.token_name) as ukey
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
 