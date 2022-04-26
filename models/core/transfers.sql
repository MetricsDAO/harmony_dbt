{{ 
    config(
        materialized='incremental', 
        unique_key= 'log_id',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by = ['block_timestamp']
    ) 
}}

with logs as (
    select 
        log_id,
        block_id,
        block_timestamp,
        ingested_at,
        tx_hash,
        evm_contract_address, 
        event_name, 
        event_inputs
    from {{ ref('logs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

transfers as (
    select
        log_id,
        block_id,
        tx_hash,
        block_timestamp,
        ingested_at,
        evm_contract_address::string as contract_address,
        event_inputs:from::string as from_address,
        event_inputs:to::string as to_address,
        event_inputs:value::float as raw_amount
    from logs
    where event_name = 'Transfer'
    and raw_amount is not null
)

select * from transfers
