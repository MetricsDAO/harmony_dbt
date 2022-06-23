{{ config(
    materialized = 'incremental',
    tags = ['metrics'],
    incremental_strategy = 'delete+insert',
    unique_key = ['day_date', 'evm_contract_address'],
    cluster_by = ['day_date']
) }}

WITH logs AS (

    SELECT
        block_timestamp,
        ingested_at,
        event_name,
        evm_contract_address,
        topics,
        event_inputs : from :: STRING AS mint,
        event_inputs : to :: STRING AS burn
    FROM
        {{ ref("logs") }}
    WHERE
        {{ incremental_last_x_days(
            'block_timestamp',
            '3'
        ) }}
),
events AS (
    SELECT
        block_timestamp,
        ingested_at,
        event_name,
        evm_contract_address,
        mint,
        burn
    FROM
        logs
    WHERE
        topics [0] = '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef'
),
mint AS (
    SELECT
        evm_contract_address,
        DATE_TRUNC(
            'day',
            block_timestamp
        ) AS day_date,
        COUNT(1) AS daily_count
    FROM
        events
    WHERE
        mint = '0x0000000000000000000000000000000000000000'
    GROUP BY
        1,
        2
),
burn AS (
    SELECT
        evm_contract_address,
        DATE_TRUNC(
            'day',
            block_timestamp
        ) AS day_date,
        COUNT(1) AS daily_count
    FROM
        events
    WHERE
        burn = '0x0000000000000000000000000000000000000000'
    GROUP BY
        1,
        2
),
FINAL AS (
    SELECT
        NVL(
            m.evm_contract_address,
            b.evm_contract_address
        ) AS evm_contract_address,
        NVL(
            m.day_date,
            b.day_date
        ) AS day_date,
        m.daily_count AS tokens_minted,
        b.daily_count AS tokens_burned
    FROM
        mint m
        LEFT JOIN burn b
        ON m.day_date = b.day_date
)
SELECT
    *
FROM
    FINAL
