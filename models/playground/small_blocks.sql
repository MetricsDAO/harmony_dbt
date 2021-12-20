{{ config(materialized='incremental', unique_key='tx_id', tags=['playground', 'small_blocks']) }}
SELECT 
    *
FROM "HARMONY"."DEV"."BLOCKS" q
where block_timestamp > CURRENT_DATE - 2