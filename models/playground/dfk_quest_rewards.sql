{{ config(materialized='table', unique_key="CONCAT_WS('-', block_timestamp, tx_id, eth_contract_address)", tags=['DFK', 'quest_rewards']) }}
/*
select * from harmony.dev.ant_logs
where tx_id = '0x4e7318d0533770cc4cd45720ac646b6ac38e909d158caeaf867a26c9509a7dec'
*/
with all_quest_rewards as (
select (tx_id) as quest_tx
from harmony.dev.txs
where 1=1
--and tx_id = '0x4e7318d0533770cc4cd45720ac646b6ac38e909d158caeaf867a26c9509a7dec'
and eth_to_address = '0x5100bd31b822371108a0f63dcfb6594b9919eaf4'
and substr(input,0,10) = '0x528be0a9'
)

select
block_timestamp,
eth_contract_address,
al.contract_name,
event_inputs:from as from_address,
event_inputs:to as to_address,
event_inputs:value as value,
tx_id
from harmony.dev.ant_logs
LEFT JOIN harmony.dev.ant_labels al on eth_contract_address = al.contract_address
where tx_id in (select quest_tx from all_quest_rewards)
and event_emitted_name = 'Transfer'
--and to_address = '0xaf85d230901e10dd023c32c293e81c91bf508740' -- gonna trace this user -- 554 records
--and to_address = '0xa8c5115c8e44351b2bc2d401a1f033bb45129dc5' -- this is the public test account
order by block_timestamp asc

-- select count(1) from all_quest_rewards

/*
substr(input,0,10)
0x2e0703dc
0xc249e4b5
0x68ce0b56 -- unknown
0x528be0a9 -- claim reward
0xc855dea3 -- startquest?
0xfe90ff7d
*/