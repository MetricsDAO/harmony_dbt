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
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

vaults as (
    select distinct 
        event_inputs:_to::string as vault_address
    from logs
    where evm_contract_address = '0xdc54046c0451f9269fee1840aec808d36015697d' -- HMY_ONE_BTC_CONTRACT
        and event_name = 'IssueTokens'
),
transfers as (
    select
        *
    from  {{ ref('transfers') }}
    where {{ incremental_load_filter("ingested_at") }}
),
final as (
  select 
    t.log_id,
    t.block_id,
    t.tx_hash,
    t.block_timestamp,
    t.ingested_at,
    t.contract_address,
    t.from_address,
    t.to_address,
    case 
      when t.from_address = '0x0000000000000000000000000000000000000000' then 'issue'
      when t.to_address = '0x0000000000000000000000000000000000000000' then 'redeem'
    end as tx_type,
    v.vault_address is not null as is_vault,
    t.raw_amount
  from transfers as t 
  left join vaults as v 
    on t.to_address = v.vault_address
  where 
    t.contract_address = '0xdc54046c0451f9269fee1840aec808d36015697d' -- HMY_ONE_BTC_CONTRACT
    and (t.from_address = '0x0000000000000000000000000000000000000000'  -- issue
        or t.to_address = '0x0000000000000000000000000000000000000000') -- redeem
)

select * from final
