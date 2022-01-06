{{ config(
    materialized = 'incremental',
    unique_key = 'HASH',
    tags = ['core'],
    cluster_by = ['block_timestamp']
) }}

select
    block_timestamp,
    tx:nonce::string as nonce,
    tx_block_index as "INDEX",
    tx :bech32_from :: string as native_from_address,
    tx :bech32_to :: string as native_to_address,
    tx :from :: string as from_address,
    tx :to :: string as to_address,
    tx :value as "VALUE",
    tx :block_number as block_number,
    tx :block_hash :: string as block_hash,
    tx :gas_price as gas_price,
    tx :gas as gas,
    tx_id as "HASH",
    tx :input :: string as "DATA",
    tx:receipt:status::string = '0x1'  as "STATUS"
from
    {{ deduped_txs("harmony_txs") }}
where
    {{ incremental_load_filter("block_timestamp") }}
