{{ 
    config(
        materialized='incremental', 
        unique_key= "CONCAT_WS('-', 'log_id', 'block_id', 'tx_hash', coalesce('from_address',''), coalesce('to_address',''), coalesce('contract_address',''), coalesce('raw_amount',-1))",
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by = ['block_timestamp']
    ) 
}}

with 

logs as (

  select 

    log_id,
    block_id, 
    block_timestamp, 
    tx_hash,
    evm_contract_address, 
    event_name, 
    event_inputs

  from {{ ref('logs') }}
  where {{ incremental_load_filter("block_timestamp") }}

),

transfers as (

  select

    log_id,
    block_id,
    tx_hash,
    block_timestamp,
    evm_contract_address::string as contract_address,
    event_inputs:from::string as from_address,
    event_inputs:to::string as to_address,
    event_inputs:value::float as raw_amount

  from logs
  where event_name::string = 'Transfer'
  and event_inputs:value is not null

) 

select * from transfers
