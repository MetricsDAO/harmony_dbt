{{ 
    config(
        materialized='incremental',
        tags=['metrics'],
        incremental_strategy = 'delete+insert',
        unique_key=['day_date'],
        cluster_by=['day_date']
    )
}}

with
logs as (
select
    block_timestamp,
    ingested_at,
    event_name,
    evm_contract_address,
    topics,
    event_inputs:_from::string as mint,
    event_inputs:_to::string as burn
from {{ ref("logs") }}
where {{ incremental_last_x_days('block_timestamp', '3')}}
),
events as (
select
    block_timestamp,
    ingested_at,
    event_name,
    evm_contract_address,
    mint,
    burn
from logs
where topics[0] = '0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62'
),

mint as (
select
    evm_contract_address,
    date_trunc('day', block_timestamp) as day_date,
    count(1) as daily_count
from
    events
where mint='0x0000000000000000000000000000000000000000'
group by 1,2
),

burn as (
select
    evm_contract_address,
    date_trunc('day', block_timestamp) as day_date,
    count(1) as daily_count
from
    events
where burn='0x0000000000000000000000000000000000000000'
group by 1,2
),

final as (
select 
  nvl(m.evm_contract_address, b.evm_contract_address) as evm_contract_address,
  nvl(m.day_date, b.day_date) as day_date,
  m.daily_count as tokens_minted,
  b.daily_count as tokens_burned
  from mint m 
  left join burn b on m.day_date = b.day_date
)

select * from final