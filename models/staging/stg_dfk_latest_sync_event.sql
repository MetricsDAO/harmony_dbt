{{ 
    config(
        materialized='incremental',
        unique_key='ingest_timestamp || evm_contract_address',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['ingest_timestamp'],
        full_refresh=false
        )
}}

select 
    current_date() as ingest_timestamp,
    *
from {{ ref("fct_dfk_latest_sync_event") }}