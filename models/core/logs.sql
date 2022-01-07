{{
    config(
        materialized='incremental',
        tags=['core'],
        cluster_by=['block_timestamp']
    )
}}

with harmony_txs as (

  select * from {{ source("chainwalkers", "harmony_txs") }}

),

logs_raw as (

    select

        block_id,
        block_timestamp,
        tx_id as tx_hash,
        tx:receipt:logs as full_logs

    from harmony_txs

),

logs as (

  select

    block_id,
    block_timestamp,
    tx_hash,
    -- full_logs,
    -- value,
    value:logIndex as event_index,
    value:bech32_address as native_contract_address,
    value:address as evm_contract_address,
    value:decoded:contractName as contract_name,
    value:decoded:eventName as event_name,
    value:decoded:inputs as event_inputs,
    value:topics as topics,
    value:data as data,
    value:removed as event_removed

  from logs_raw,
  lateral flatten ( input => full_logs )

)

select * from logs
