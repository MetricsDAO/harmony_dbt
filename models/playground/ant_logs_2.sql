{{ config(materialized='incremental', unique_key="CONCAT_WS('-', tx_id, transactionIndex, logIndex)", tags=['playground', 'ant_logs2']) }}

WITH
parse_once as (
  select distinct PARSE_JSON(C1) as parsed from harmony.dev.ant_raw_logs
)
,parsed_ant_logs as (
  select 
   parsed:topics as topics
  ,parsed:address as contract_address
  ,parsed:transactionHash as tx_id
  ,parsed:data as logData
  ,parsed:blockNumber as blockNumberHex
  ,java_hextoint(substr(parsed:blockNumber,3,20))::INTEGER as blockNumber
  ,parsed:transactionIndex as transactionIndex
  ,parsed:logIndex as logIndex
  ,parsed:removed as event_removed
  from parse_once
)
  
select 
*
from parsed_ant_logs