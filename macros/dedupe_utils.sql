{% macro deduped_src_table(src_name, table_name) -%}
    (
        SELECT
            *
        FROM
        (
            SELECT 
                *,
                row_number() OVER (PARTITION BY block_id, ingested_at ORDER BY ingested_at DESC) AS rn
            FROM {{source(src_name, table_name)}}
        ) sq
        WHERE
        sq.rn = 1
    )
{%- endmacro %}
