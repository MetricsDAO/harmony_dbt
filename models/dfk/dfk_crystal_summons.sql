{{ 
    config(
        materialized='incremental',
        unique_key='tx_hash',
        incremental_strategy = 'delete+insert',
        tags=['dfk'],
        cluster_by=['block_timestamp']
        ) 
}}

with

gaiatear_price as (
    select
        *
    from {{ ref("tokenprice_gaiatear") }}
),

jewel_price as (
    select
        *
    from {{ ref("tokenprice_jewel") }}
),

logs as (
    select
        *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("block_timestamp") }}
),

txs as (
    select
        *
    from {{ ref("txs") }}
    where {{ incremental_load_filter("block_timestamp") }}
),

summon_tx as (

    select 
        tx_hash
    from txs
    where to_address = '0x65dea93f7b886c33a78c10343267dd39727778c2'
        or to_address = '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355'

),

costs_to_summon AS (
    select 
        evm_contract_address,
        tx_hash,
        sum(event_inputs:value) as amount
    from logs
    where tx_hash in (select tx_hash from summon_tx)
        and event_name = 'Transfer'
        and evm_contract_address != '0x5f753dcdf9b1ad9aabc1346614d1f4746fd6ce5c'
    group by 1, 2
),

final as (
    select
        logs.block_timestamp,
        concat('0x',substr(logs.data,3,64)) as crystal_id,
        t.amount as tears_amount,
        j.amount / pow(10,18) as jewel_amount,
        logs.tx_hash,
        jewel_amount * p.price as jewel_amount_usd,
        tears_amount * gaiatear.price as tear_amount_usd,
        nvl(jewel_amount_usd,0)+nvl(tear_amount_usd,0) as amount_usd
    from logs
    left join costs_to_summon as t
        on  t.tx_hash = logs.tx_hash and t.evm_contract_address = '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04'
    left join costs_to_summon as j
        on j.tx_hash = logs.tx_hash and j.evm_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
    left join jewel_price as p
        on date(logs.block_timestamp) = date(p.timestamp)
    left join gaiatear_price as gaiatear
        on date(logs.block_timestamp) = date(gaiatear.timestamp)
    where logs.tx_hash in (select tx_hash from summon_tx)
        and logs.topics[0] = '0x4508aba30a57c0fc7f1d5da83dea7dd0c36368a7080d3a6652fcd5a58168f460'
)

select * from final

