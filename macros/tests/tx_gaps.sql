{% macro tx_gaps(
        model
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
            block_id,
            COUNT(
                DISTINCT tx_hash
            ) AS model_tx_count
        FROM
            {{ model }}
        GROUP BY
            block_id
    )
SELECT
    block_base.block_id,
    tx_count,
    model_name.block_id,
    model_tx_count
FROM
    block_base
    LEFT JOIN model_name
    ON block_base.block_id = model_name.block_id
WHERE
    tx_count <> model_tx_count
{% endmacro %}
