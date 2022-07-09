{{ config(
    materialized = 'incremental',
    unique_key = 'tx_hash',
    tags = ['core'],
    cluster_by = ['block_timestamp']
) }}

WITH base_txs AS (

    SELECT
        *
    FROM
        {{ ref("stg_txs") }}
    WHERE
        {{ incremental_load_filter("ingested_at") }}
),

gas_used as (
    select
        block_id,
        tx_block_index,
        js_hextoint(tx:receipt:cumulativeGasUsed) as cumulative_gas,
        cumulative_gas - ifnull(lag(cumulative_gas) over (partition by block_id order by tx_block_index ASC), 0) as gas_used
    from base_txs
),

FINAL AS (
SELECT
        block_timestamp,
        ingested_at,
        tx :nonce :: STRING AS nonce,
        base_txs.tx_block_index AS INDEX,
        tx :bech32_from :: STRING AS native_from_address,
        tx :bech32_to :: STRING AS native_to_address,
        tx :from :: STRING AS from_address,
        tx :to :: STRING AS to_address,
        tx :value AS VALUE,
        tx :block_number AS block_number,
        tx :block_hash :: STRING AS block_hash,
        tx :gas_price AS gas_price,
        tx :gas AS gas_limit,
        gas_used.gas_used AS gas_used,
        tx_id AS tx_hash,
        tx :input :: STRING AS DATA,
        tx :receipt :status :: STRING = '0x1' AS status
    FROM
        base_txs
    inner join gas_used
        on base_txs.block_id = gas_used.block_id
       and base_txs.tx_block_index = gas_used.tx_block_index
)
SELECT
    *
FROM
    FINAL
