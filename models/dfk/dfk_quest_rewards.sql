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

jewel_price as (
    select 
        *
    from {{ ref("tokenprice_jewel") }}
),

tear_price as (
    select
        *
    from {{ ref("tokenprice_gaiatear") }}
),

shva_price as (
    select
        *
    from {{ ref("tokenprice_shvasrune") }}
),

gold_price as (
    select
        *
    from {{ ref("tokenprice_dfkgold") }}
),

logs as (
    select
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("ingested_at") }}
),

item2gold as (
    select
        *
    from {{ ref('dfk_item_to_gold') }}
),

tokens as (
    select
        *
    from {{ ref('tokens') }}
),

all_quest_rewards as (
    select
        tx_hash as quest_tx
    from {{ ref('txs') }}
    where {{ incremental_load_filter("ingested_at") }}
        and (   to_address = '0x5100bd31b822371108a0f63dcfb6594b9919eaf4' -- quest_contract
                or to_address = '0xaa9a289ce0565e4d6548e63a441e7c084e6b52f6' -- quest_contract_new
            )
        and substr(data,0,10) = '0x528be0a9' -- collect quest rewards
),

final as (
    select
        logs.log_id,
        logs.block_timestamp,
        logs.ingested_at,
        logs.evm_contract_address,
        tokens.token_name,
        logs.event_inputs:from as from_address,
        logs.event_inputs:to as to_address,
        logs.event_inputs:value / pow(10, tokens.decimals) as calculated_value,
        logs.tx_hash,
        case 
            when logs.evm_contract_address::string = '0x72cb10c6bfa5624dd07ef608027e366bd690048f' then nvl(calculated_value * jewel_price.price, 0) 
            when logs.evm_contract_address::string = '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04' then nvl(calculated_value * tear_price.price, 0)
            when logs.evm_contract_address::string = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286' then nvl(calculated_value * shva_price.price, 0)
            when logs.evm_contract_address::string = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7' then nvl(calculated_value * gold_price.price, 0)
            else nvl( calculated_value * item2gold.gold * gold_price.price, 0 )
        end as amount_usd
    from logs
    left join tokens
        on logs.evm_contract_address = tokens.token_address
    left join jewel_price
        on date(logs.block_timestamp) = date(jewel_price.timestamp)
    left join tear_price
        on date(logs.block_timestamp) = date(tear_price.timestamp)
    left join gold_price
        on date(logs.block_timestamp) = date(gold_price.timestamp)
    left join shva_price
        on date(logs.block_timestamp) = date(shva_price.timestamp)
    left join item2gold
        on logs.evm_contract_address = item2gold.contract_address
    where event_name = 'Transfer'
        and logs.tx_hash in ( select quest_tx from all_quest_rewards )
)

select * from final
