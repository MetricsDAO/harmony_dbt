{{
    config(
        materialized='table',
        unique_key='log_id',
        tags=['core', 'defi', 'amm', 'lending']
        )
}}

with

tranquil_market_labels as (
    select
        *
    from {{ ref('tranquil_market_labels') }}
),

-- Tranquil contracts all have the same "Creator" or admin address
tranquil_contracts as (
    select distinct evm_contract_address
    from logs 
    where event_inputs:admin::string = '0x15424ab0bbab79bad32ce779197748485b5ae456'
), 

tranquil_markets_usd as (  
    select * 
    from {{ ref('tranquil_markets_tokenprice') }}
),

tranquil_deposits as (

select 
    logs.log_id
    , logs.tx_hash
    , block_timestamp
    , block_id
    , event_inputs:minter::string as user_address
    , logs.evm_contract_address
    , tml.token_symbol
    , (event_inputs:mintAmount::number) as token_amount_raw
    , (event_inputs:mintAmount::number / pow(10, tml.decimals)) as token_amount
    , 'Deposit' as tx_type
from logs 
inner join tranquil_contracts as tc 
    on logs.evm_contract_address = tc.evm_contract_address
left join tranquil_market_labels as tml
    on logs.evm_contract_address = tml.token_address
where 1=1
    and logs.event_name = 'Mint'
),

tranquil_borrows as (

select 
    logs.log_id
    , logs.tx_hash
    , block_timestamp
    , block_id
    , event_inputs:borrower::string as user_address
    , logs.evm_contract_address
    , tml.token_symbol
    , (event_inputs:borrowAmount::number) as token_amount_raw
    , (event_inputs:borrowAmount::number / pow(10, tml.decimals)) as token_amount
    , 'Borrow' as tx_type
from logs 
inner join tranquil_contracts as tc 
    on logs.evm_contract_address = tc.evm_contract_address
left join tranquil_market_labels as tml
    on logs.evm_contract_address = tml.token_address
where 1=1
    and logs.event_name = 'Borrow'
),

tranquil_repayments as (

select 
    logs.log_id
    , logs.tx_hash
    , block_timestamp
    , block_id
    , event_inputs:borrower::string as user_address
    , logs.evm_contract_address
    , tml.token_symbol
    , (event_inputs:repayAmount::number) as token_amount_raw
    , (event_inputs:repayAmount::number / pow(10, tml.decimals)) as token_amount
    , 'Repayment' as tx_type
from logs 
inner join tranquil_contracts as tc 
    on logs.evm_contract_address = tc.evm_contract_address
left join tranquil_market_labels as tml
    on logs.evm_contract_address = tml.token_address
where 1=1
    and logs.event_name = 'RepayBorrow'
),

tranquil_withdrawals as (

select 
    logs.log_id
    , logs.tx_hash
    , block_timestamp
    , block_id
    , event_inputs:redeemer::string as user_address
    , logs.evm_contract_address
    , tml.token_symbol
    , (event_inputs:redeemAmount::number) as token_amount_raw
    , (event_inputs:redeemAmount::number / pow(10, tml.decimals)) as token_amount
    , 'Withdrawal' as tx_type
from logs 
inner join tranquil_contracts as tc 
    on logs.evm_contract_address = tc.evm_contract_address
left join tranquil_market_labels as tml
    on logs.evm_contract_address = tml.token_address
where 1=1
    and logs.event_name = 'Redeem'
),

combined as (

    select * from tranquil_deposits
    union all
    select * from tranquil_borrows
    union all
    select * from tranquil_repayments
    union all
    select * from tranquil_withdrawals
),

final as (
    -- add in amount_usd lookup
    select c.*
        , (usd.price * c.token_amount) as amount_usd
    from combined as c
    left join tranquil_markets_usd usd 
        on date_trunc('day', c.block_timestamp) = usd.timestamp
        and c.token_symbol = usd.token_symbol

)

select * from final
    



