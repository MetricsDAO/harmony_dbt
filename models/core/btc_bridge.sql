{{ 
    config(
        materialized='incremental', 
        unique_key= 'log_id',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by = ['block_timestamp']
    ) 
}}
-- Collateral is required to launch a vault
with vaults as (

select 
  distinct event_inputs:_to::string as vault_address
from {{ ref('logs') }}
where 
  evm_contract_address = '0xdc54046c0451f9269fee1840aec808d36015697d' -- HMY_ONE_BTC_CONTRACT
  and event_name = 'IssueTokens'

)

select 
  log_id,
  block_id,
  tx_hash,
  block_timestamp,
  contract_address,
  from_address,
  to_address,
  case 
    when from_address = '0x0000000000000000000000000000000000000000' then 'issue'
    when to_address = '0x0000000000000000000000000000000000000000' then 'redeem'
  end as tx_type,
  v.vault_address is not null as is_vault,
  raw_amount
from {{ ref('transfers') }} as t 
left join vaults as v 
  on t.to_address = v.vault_address
where 
  {{ incremental_load_filter("block_timestamp") }}
  and contract_address = '0xdc54046c0451f9269fee1840aec808d36015697d' -- HMY_ONE_BTC_CONTRACT
  and (from_address = '0x0000000000000000000000000000000000000000'  -- issue
       or to_address = '0x0000000000000000000000000000000000000000') -- redeem
