{{ config(
    materialized = 'incremental',
    unique_key = 'hash',
    tags = ['core']
) }}

select
    block_timestamp,
    tx :nonce :: string as nonce,
    tx_block_index as tx_index,
    tx :bech32_from :: string as native_from_address,
    tx :bech32_to :: string as native_to_address,
    tx :from :: string as eth_from_address,
    tx :to :: string as eth_to_address,
    tx :value as "value",
    tx :block_number as block_number,
    tx :block_hash :: string as block_hash,
    tx :gas_price as gas_price,
    tx :gas as gas,
    tx_id as "hash",
    tx :input :: string as data,
    case
        when tx :receipt :status :: string = '0x0' then FALSE
        else TRUE
    end as status
from
    {{ deduped_txs("harmony_txs") }}
    {{ incremental_load_filter("block_timestamp") }}
