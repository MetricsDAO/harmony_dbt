{{ config(materialized='incremental', unique_key="CONCAT_WS('-', bt.tx_id, bt.tx_index, one_log.event_index)", tags=['playground', 'ant_logs']) }}

with base_txs as (
select 
    q.block_id,
    q.block_timestamp,
    q.tx_id,
    q.tx_block_index as tx_index,
    tx:receipt:logs as events_emitted
from {{ deduped_txs("harmony_txs") }} q

-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
where {{ incremental_load_filter("block_timestamp") }}
)

select 
    bt.block_id,
    bt.block_timestamp,
    bt.tx_id,
    bt.tx_index,
    one_log.value:address as eth_contract_address, -- this is the contract address(0x) that emitted this event
    one_log.value:bech32_address as native_contract_address, -- this is the contract address(one) that emitted this event
    one_log.value:decoded:contractName as contract_name, -- unsure, probably labels, always looks empty.
    one_log.value:decoded:eventName as event_emitted_name, -- event name that was emitted
    one_log.value:decoded:inputs as event_inputs, -- event_inputs
    one_log.value:logIndex as event_index, -- event_index of the whole tx
    one_log.value:removed as event_removed -- if the event was removed becase it was invalid
from base_txs bt, lateral flatten (input => events_emitted) one_log
where events_emitted is not null
