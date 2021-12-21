-- {{ config(materialized='view', unique_key='tx_id', tags=['playground']) }}
{{ config(materialized='incremental', unique_key='tx_id', tags=['playground', 'ant_dex_swaps_jewel']) }}

select
    block_id,
    block_timestamp,
    tx_id,
    tx_block_index as tx_index,
    tx:bech32_from::string as native_from_address,
    tx:bech32_to::string as native_to_address,
    tx:from::string as eth_from_address,
    tx:to::string as eth_to_address,
    tx:value as amount,
    tx:gas as gas,
    tx:gas_price as gas_price,
    tx:input::string as input,
    tx:receipt:logs as event_logs
FROM {{ deduped_txs("harmony_txs") }} q

-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
/* {{ incremental_load_filter("block_timestamp") }} */

-- other "AND" conditions
where 1=1
and eth_to_address = '0x24ad62502d1c652cc7684081169d04896ac20f30'
and substr(input,0,10) in ('0x7ff36ab5' -- swapExactETHForTokens 
                          ,'0x38ed1739' -- swapExactTokensForTokens
                          ,'0x18cbafe5' -- swapExactTokensForETH
                          )
