{{ 
    config(
        materialized='incremental'
        ,unique_key='u_key'
        ,tags=['playground', 'ant_logs']
        ,cluster_by=['block_timestamp']
        ) 
}}

select
concat_ws('-', q.block_id, q.tx_id, one_log.value:logIndex) as u_key
,q.block_id as block_id
,q.block_timestamp as block_timestamp
,q.tx_id as tx_id
,q.tx_block_index as tx_index
,one_log.value:address as eth_contract_address -- this is the contract address(0x) that emitted this event
,one_log.value:bech32_address as native_contract_address -- this is the contract address(one) that emitted this event
,one_log.value:decoded:contractName as contract_name -- decoded contract name, if it exists
,one_log.value:decoded:eventName as event_emitted_name -- decoded event name that was emitted, if it exists
,one_log.value:decoded:inputs as event_inputs -- decoded event_inputs, if it exists
,one_log.value:logIndex as event_index -- event_index of the whole tx
,one_log.value:removed as event_removed -- if the event was removed becase it was invalid
,one_log.value:data as value -- data returned from the contract
,one_log.value:topics as topics -- topics from the log
from {{ deduped_txs("harmony_txs") }} q, lateral flatten (input => q.tx:receipt:logs) one_log

-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
where {{ incremental_load_filter("block_timestamp") }}