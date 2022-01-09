{{ 
    config(
        materialized='view',
        tags=['core']
        )
}}

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
    tx:input::string as input
from {{ ref("txs_deduped") }} q