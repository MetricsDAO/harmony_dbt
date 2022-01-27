{{ config(materialized='incremental', unique_key='g0p.tx_id', tags=['playground', 'ant_dfk_gen0']) }}

WITH GEN0PURCHASES as (
select 
tx_id
,concat('0x', substr(logdata,3,64)) as crystal_id
,java_hextoint(concat('', substr(logdata,3+64,64))) as created_block
,java_hextoint(concat('', substr(logdata,3+64+64,64)))/pow(10,18) as jewel_price
,concat('0x',substr(topics[1],3+24,40)) as owner
from harmony.dev.ant_logs_2
where topics[0] = '0x4cb4935c643485980bf65dfc041fc48f0a40c62bbb328843837c786dbc98f1c5'
)

, HEROSUMMONS AS (
select 
tx_id
,concat('0x', substr(logdata,3,64)) as crystal_id
,concat('0x', substr(logdata,3+64,64)) as hero_id
from harmony.dev.ant_logs_2
where 1=1 
and topics[0] = '0xa6537abb32df743f25343a89920580e228e72ebe25cbbb40b6d83ce4aab0a425'
and contract_address = '0xdf0bf714e80f5e6c994f16b05b7ffcbcb83b89e9'
)

select 
g0p.tx_id as summon_crystal_tx
,g0p.crystal_id as crystal_id
,g0p.created_block
,g0p.jewel_price
,g0p.owner as creator
,hs.tx_id as summon_hero_tx
,hs.hero_id as hero_id
from GEN0PURCHASES g0p
LEFT JOIN HEROSUMMONS hs on g0p.crystal_id = hs.crystal_id
order by created_block asc