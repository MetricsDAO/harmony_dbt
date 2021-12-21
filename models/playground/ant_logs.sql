-- {{ config(materialized='view', unique_key='tx_id', tags=['playground']) }}
{{ config(materialized='incremental', unique_key="CONCAT_WS('-', tx_id, tx_index, event_index)", tags=['playground', 'ant_logs']) }}

/*
Important data
    "address": "0x25836011bbc0d5b6db96b20361a474cbc5245b45",
    "bech32_address": "one1ykpkqydmcr2mdkukkgpkrfr5e0zjgk697zqknm",
    "blockHash": "0xee0dd06e01784b97b42661b568d6959b707943f300ac123e047d5cdf13206cb8",
    "blockNumber": "0x13ade4a",
    "decoded": {
      "contractName": "",
      "eventName": "LogUpdatePool",
      "inputs": {
        "accSushiPerShare": 29117804627099,
        "lastRewardBlock": 1639811090,
        "lpSupply": 2.527064186596634e+23,
        "pid": 3
      },
    "transactionHash": "0xec1c8ed4593b3bd2701837025222eece8379bffe431e0beca4a40ad9fa444046",
    "logIndex": "0x2",
    "removed": false,

    --maybes?
    "topics": [
      "0x0fc9545022a542541ad085d091fb09a2ab36fee366a4576ab63714ea907ad353",
      "0x0000000000000000000000000000000000000000000000000000000000000003"
    ],
*/
select 
    block_id,
    block_timestamp,
    tx_id,
    tx_block_index as tx_index,
    --one_log.value as raw_tx_log, -- raw log, for debugging
    one_log.value:address as eth_contract_address, -- this is the contract address(0x) that emitted this event
    one_log.value:bech32_address as native_contract_address, -- this is the contract address(one) that emitted this event
    one_log.value:decoded:contractName as contract_name, -- TODO: unsure, probably labels, probably always empty.
    one_log.value:decoded:eventName as event_emitted_name, -- event name that was emitted
    one_log.value:decoded:inputs as event_inputs, -- event_inputs
    one_log.value:logIndex as event_index, -- event_index of the whole tx
    one_log.value:removed as event_removed -- TODO: unsure, if the event was removed?
from {{ deduped_txs("harmony_txs") }} q
,lateral flatten (input => tx:receipt:logs) one_log

-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
/* {{ incremental_load_filter("block_timestamp") }} */

-- other "AND" conditions
where event_inputs is not null

/* how to promote from simple sql to prod */
/*
1. uncomment this above -> {{ incremental_load_filter("block_timestamp") }}
2. remove any limits LIMIT 1000
3. fix the incremental load filter as it has the where clause..
*/