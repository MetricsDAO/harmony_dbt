{{ 
    config(
        materialized='incremental',
        unique_key='ukey',
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
        ingest_timestamp,
        java_hextoint(substr(parsed_data:data:result,3)) as supply,
        parsed_data:token as token_address,
        t.token_name,
        date_trunc('day',ingest_timestamp) as day_date
    from subselect_source
    left join harmony.dev.tokens t
        on t.token_address = parsed_data:token
)
  
select * from final
 