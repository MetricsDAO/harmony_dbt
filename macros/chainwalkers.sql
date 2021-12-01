{% macro chainwalker_blocks(table_name) -%}
    (
        SELECT
            *
        FROM
        (
            SELECT 
                *,
                row_number() OVER (PARTITION BY block_id, ingested_at ORDER BY ingested_at DESC) AS rn
            FROM {{source('chainwalkers', table_name)}}
        ) sq
        WHERE
        sq.rn = 1
    )
{%- endmacro %}

{% macro chainwalker_txs(table_name) -%}
    (
        SELECT
            sq.block_id,
            sq.block_timestamp,
            sq.ingested_at,
            sq.tx_count,
            t.index as tx_index,
            t.value as tx
        FROM 
            {{chainwalker_blocks(table_name)}} sq,
            Table(Flatten(sq.txs)) t
        ORDER BY sq.block_id DESC, tx_index DESC
    )
{%- endmacro %}
