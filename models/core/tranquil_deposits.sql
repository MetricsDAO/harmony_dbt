{{
    config(
        materialized='table',
        unique_key='tx_hash',
        tags=['core', 'defi', 'amm', 'lending']
        )
}}

with

tranquil_contracts as (
    select
        *
    from {{ ref('tranquil_market_labels') }}
),

--token_price as (

--),

final as (

select 
    logs.tx_hash
    , block_timestamp
    , block_id
    , event_inputs:minter::string as user_address
    , logs.evm_contract_address
    , tc.token_symbol
    , event_inputs:mintAmount::number as token_amount_raw
    , event_inputs:mintAmount::number / pow(10, tc.decimals) as token_amount
    , null as amount_usd
from logs 
inner join tranquil_contracts as tc 
    on logs.evm_contract_address = tc.token_address
where 1=1
    and logs.event_name = 'Mint'
)

select * from final
    



