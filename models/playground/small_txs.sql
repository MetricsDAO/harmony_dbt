{{ config(materialized='incremental', unique_key='tx_id', tags=['playground', 'small_txs']) }}
SELECT 
    *
FROM "HARMONY"."DEV"."TXS" q
where date(block_timestamp) > CURRENT_DATE - 2
