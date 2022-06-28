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
FINAL AS (
    SELECT
        block_timestamp,
        ingested_at,
        tx :nonce :: STRING AS nonce,
        tx_block_index AS INDEX,
        tx :bech32_from :: STRING AS native_from_address,
        tx :bech32_to :: STRING AS native_to_address,
        tx :from :: STRING AS from_address,
        tx :to :: STRING AS to_address,
        tx :value AS VALUE,
        tx :block_number AS block_number,
        tx :block_hash :: STRING AS block_hash,
        tx :gas_price AS gas_price,
        tx :gas AS gas_limit,
        js_hextoint(tx :receipt :cumulativeGasUsed) AS gas_used,
        tx_id AS tx_hash,
        tx :input :: STRING AS DATA,
        tx :receipt :status :: STRING = '0x1' AS status
    FROM
        base_txs
)
SELECT
    *
FROM
    FINAL
