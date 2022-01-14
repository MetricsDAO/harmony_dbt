{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_txs']) }}

select 
block_timestamp
,nonce
,index
,native_from_address
,native_to_address
,from_address as eth_from_address
,to_address as eth_to_address
,value as amount
,block_number as block_id
,block_hash
,gas_price
,gas
,tx_hash as tx_id
,data as input
,status
from harmony.prod.txs