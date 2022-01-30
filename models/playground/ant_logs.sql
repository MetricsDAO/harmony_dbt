{{ 
    config(
        materialized='incremental',
        unique_key='u_key',
        incremental_strategy = 'delete+insert',
        tags=['playground'],
        cluster_by=['block_timestamp']
        ) 
}}
select
log_id as u_key,
block_id as block_id,
block_timestamp as block_timestamp,
tx_hash as tx_id,
native_contract_address, -- this is the contract address(one) that emitted this event
evm_contract_address as eth_contract_address, -- this is the contract address(0x) that emitted this event
contract_name, -- decoded contract name, if it exists
event_name as event_emitted_name, -- decoded event name that was emitted, if it exists
event_inputs, -- decoded event_inputs, if it exists
event_index -- event_index of the whole tx
topics,
data as value -- log output field
from {{ ref("logs") }}

-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
where {{ incremental_load_filter("block_timestamp") }}