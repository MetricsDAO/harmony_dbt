{% macro deduped_blocks(table_name) -%}
    (
        SELECT
            *
        FROM
        (
            SELECT 
                *,
                row_number() OVER (PARTITION BY block_id ORDER BY ingested_at DESC) AS rn
            FROM {{source("chainwalkers", table_name)}}
        ) sq
        WHERE
        sq.rn = 1
    )
{%- endmacro %}

{% macro deduped_txs(table_name ) -%}
    (
        SELECT
            *
        FROM
        (
            SELECT 
                *,
                row_number() OVER (PARTITION BY tx_id ORDER BY ingested_at DESC) AS rn
            FROM {{source("chainwalkers", table_name)}}
        ) sq
        WHERE
        sq.rn = 1
    )
{%- endmacro %}
