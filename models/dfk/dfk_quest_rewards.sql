{{ 
    config(
        materialized='incremental',
        unique_key='log_id',
        incremental_strategy = 'delete+insert',
        tags=['dfk', 'dfk_quest_rewards'],
        cluster_by=['block_timestamp']
        ) 
}}

with

all_quest_rewards as (
    select
        tx_hash as quest_tx
    from {{ ref('txs') }}
    where {{ incremental_load_filter("block_timestamp") }}
    and to_address = '0x5100bd31b822371108a0f63dcfb6594b9919eaf4' -- quest_contract
    and substr(data,0,10) = '0x528be0a9' -- collect quest rewards
),

final as (
    select
        l.log_id,
        l.block_timestamp,
        l.evm_contract_address,
        al.token_name,
        l.event_inputs:from as from_address,
        l.event_inputs:to as to_address,
        l.event_inputs:value / pow(10,al.decimals) as calculated_value,
        l.tx_hash,
        CASE 
            WHEN l.evm_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f' THEN nvl(calculated_value * j.price, 0) 
            WHEN l.evm_contract_address = '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04' THEN nvl(calculated_value * tear.price, 0)
            WHEN l.evm_contract_address = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286' THEN nvl(calculated_value * shva.price, 0)
            WHEN l.evm_contract_address = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7' THEN nvl(calculated_value * g.price, 0)
            ELSE nvl( calculated_value * i2g.gold * g.price, 0)
        END as amount_usd
    from {{ ref('logs') }} l
    LEFT JOIN {{ ref('tokens') }} al on l.evm_contract_address = al.token_address
    LEFT JOIN harmony.dev.ant_view_token_price_jewel j on date(l.block_timestamp) = date(j.timestamp)
    LEFT JOIN harmony.dev.ant_view_token_price_gaia tear on date(l.block_timestamp) = date(tear.timestamp)
    LEFT JOIN harmony.dev.ant_view_token_price_dfkgold g on date(l.block_timestamp) = date(g.timestamp)
    LEFT JOIN harmony.dev.ant_view_token_price_shvasrune shva on date(l.block_timestamp) = date(shva.timestamp)
    LEFT JOIN {{ ref('dfk_item_to_gold') }} i2g on l.evm_contract_address = i2g.contract_address
    where {{ incremental_load_filter("block_timestamp") }}
    and l.tx_hash in ( select quest_tx from all_quest_rewards )
    and event_name = 'Transfer'
    order by block_timestamp asc
)

select * from final