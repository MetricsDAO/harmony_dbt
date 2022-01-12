{{ config(
  materialized='incremental', 
  unique_key= "CONCAT_WS('-', 'block_id', 'tx_hash', coalesce('from_address',''), coalesce('to_address',''), coalesce('contract_address',''), coalesce('raw_amount',-1))",
  incremental_strategy = 'delete+insert',
  cluster_by = ['block_timestamp'],
  tags=['core']
) }}

with logs as (
  select 
    q.block_id, 
    q.block_timestamp, 
    q.tx_hash,
    q.evm_contract_address, 
    q.event_name, 
    q.event_inputs
  from 
    {{ ref('logs') }} q
),
transfers as (
  select
    block_id,
    tx_hash,
    block_timestamp,
    evm_contract_address::string as contract_address,
    event_inputs:from::string as from_address,
    event_inputs:to::string as to_address,
    event_inputs:value::float as raw_amount
  from 
    logs
  where 
    event_name::string = 'Transfer'
  and 
    event_inputs:value is not null
) 
select 
  *
from 
  transfers

