{{
    config(
        materialized='incremental',
        unique_key = 'log_id',
        tags=['core', 'logs'],
        cluster_by=['block_timestamp']
    )
}}

with base_txs as (

  select * from {{ ref("txs_deduped") }}

),

logs_raw as (

    select

        block_id,
        block_timestamp,
        tx_id as tx_hash,
        tx:receipt:logs as full_logs

    from base_txs
    where {{ incremental_load_filter("block_timestamp") }}

),

logs as (

  select

    block_id,
    block_timestamp,
    tx_hash,
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

),

final as (

  select

    concat_ws('-', tx_hash, event_index) as log_id,
    *

    from logs

)

select * from final
