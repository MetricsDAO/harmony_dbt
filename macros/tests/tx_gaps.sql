{% test tx_gaps(
    model,
    column_block,
    column_tx_hash
) %}
WITH block_base AS (
    SELECT
        block_id,
        tx_count
    FROM
        {{ ref('blocks') }}
),
model_name AS (
    SELECT
        {{ column_block }},
        COUNT(
            DISTINCT {{ column_tx_hash }}
        ) AS model_tx_count
    FROM
        {{ model }}
    GROUP BY
        {{ column_block }}
)
SELECT
    block_base.block_id,
    tx_count,
    model_name.{{ column_block }},
    model_tx_count
FROM
    block_base
    LEFT JOIN model_name
    ON block_base.block_id = model_name.{{ column_block }}
WHERE
    tx_count <> model_tx_count {% endtest %}
