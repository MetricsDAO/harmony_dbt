{{
    config(
        materialized='incremental',
        unique_key='tx_hash',
        tags=['dfk'],
        cluster_by=['block_timestamp']
    )
}}

with incremental_txs as (
    select *
    from {{ ref("txs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

incremental_logs as (
    select *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

market_txs as (
    select *
    from incremental_txs
    where to_address = '0xe53bf78f8b99b6d356f93f41afb9951168cca2c6'
      and (
          data like '0x9f37092a%' or -- sell
          data like '0x096c5e1a%' -- buy
      )
      and status = true
),

market_events as (
    select
        market_txs.block_timestamp as block_timestamp,
        market_txs.ingested_at as ingested_at,
        market_txs.native_from_address as native_from_address,
        market_txs.from_address as from_address,
        market_txs.tx_hash as tx_hash,
        market_txs.data as data,
        incremental_logs.event_inputs as event_inputs,
        incremental_logs.evm_contract_address as evm_contract_address
    from market_txs
    inner join incremental_logs
        on market_txs.tx_hash = incremental_logs.tx_hash
    where event_name = 'Transfer'
),

gives as (
    select
        tx_hash,
        event_inputs:value as amount,
        evm_contract_address as token
    from market_events
    where event_inputs:to = '0x0000000000000000000000000000000000000000'
),

takes as (
    select
        tx_hash,
        event_inputs:value as amount,
        evm_contract_address as token
    from market_events
    where event_inputs:from = '0x0000000000000000000000000000000000000000'
),

final as (
    select
        market_txs.tx_hash as tx_hash,
        block_timestamp,
        ingested_at,
        native_from_address,
        from_address,
        case substring(market_txs.data, 1, 10)
            when '0x9f37092a' then 'Buy'
            when '0x096c5e1a' then 'Sell'
        end as market_action,
        to_number(gives.amount)/pow(10, IFNULL(token_give.decimals, 0)) as amount_give,
        gives.token as token_give_address,
        token_give.token_symbol as token_give_symbol,
        token_give.token_name as token_give_name,
        to_number(takes.amount)/pow(10, IFNULL(token_take.decimals, 0)) as amount_take,
        takes.token as token_take_address,
        token_take.token_symbol as token_take_symbol,
        token_take.token_name as token_take_name
    from market_txs
    inner join gives
        on market_txs.tx_hash = gives.tx_hash
    inner join takes
        on market_txs.tx_hash = takes.tx_hash
    left join tokens token_give
        on gives.token = token_give.token_address
    left join tokens token_take
        on takes.token = token_take.token_address
)

select * from final
