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

jewel_price as (
    select 
        date_trunc('day',block_timestamp) as timestamp,
        1/(div0(sum(amount0In+amount0Out), sum(amount1In+amount1Out)) / pow(10,12)) as price
    from {{ ref('swaps') }}
    where {{ incremental_load_filter("block_timestamp") }}
    and token1_symbol = '1USDC'
    and token0_symbol = 'JEWEL'
    group by 1
),

tear_price as (
    select 
        i.timestamp as timestamp,
        i.ratio_jewel as ratio_jewel,
        jp.price * ratio_jewel as price
        from (
            select 
                date_trunc('day',block_timestamp) as timestamp,
                div0(sum(amount1In+amount1Out) , sum(amount0In+amount0Out)) / pow(10,18) as ratio_jewel
            from {{ ref('swaps') }} s
            where {{ incremental_load_filter("block_timestamp") }}
            and token0_symbol = 'DFKTEARS'
            and token1_symbol = 'JEWEL'
            group by 1
            ) i
    left join jewel_price jp on jp.timestamp = i.timestamp
),

shva_price as (
    select 
        i.timestamp as timestamp,
        i.ratio_jewel as ratio_jewel,
        jp.price * ratio_jewel as price
        from (
            select 
                date_trunc('day',block_timestamp) as timestamp,
                div0(sum(amount1In+amount1Out) , sum(amount0In+amount0Out)) / pow(10,18) as ratio_jewel
            from {{ ref('swaps') }} s
            where {{ incremental_load_filter("block_timestamp") }}
            and token0_symbol = 'DFKSHVAS'
            and token1_symbol = 'JEWEL'
            group by 1
            ) i
    left join jewel_price jp on jp.timestamp = i.timestamp
),

gold_price as (
    select 
        i.timestamp as timestamp,
        i.ratio_jewel as ratio_jewel,
        jp.price * i.ratio_jewel as price
    from (
        select 
            date_trunc('day',block_timestamp) as timestamp,
            div0(sum(amount1In+amount1Out) , sum(amount0In+amount0Out)) / pow(10,15) as ratio_jewel
        from {{ ref('swaps') }} s
        where {{ incremental_load_filter("block_timestamp") }}
        and token0_symbol = 'DFKGOLD'
        and token1_symbol = 'JEWEL'
        group by 1
        ) i
    left join jewel_price jp on jp.timestamp = i.timestamp
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
        case 
            when l.evm_contract_address::string = '0x72cb10c6bfa5624dd07ef608027e366bd690048f' then nvl(calculated_value * j.price, 0) 
            when l.evm_contract_address::string = '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04' then nvl(calculated_value * tear.price, 0)
            when l.evm_contract_address::string = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286' then nvl(calculated_value * shva.price, 0)
            when l.evm_contract_address::string = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7' then nvl(calculated_value * g.price, 0)
            else nvl( calculated_value * i2g.gold * g.price, 0)
        end as amount_usd
    from {{ ref('logs') }} l
    left join {{ ref('tokens') }} al on l.evm_contract_address = al.token_address
    left join jewel_price j on date(l.block_timestamp) = date(j.timestamp)
    left join tear_price tear on date(l.block_timestamp) = date(tear.timestamp)
    left join gold_price g on date(l.block_timestamp) = date(g.timestamp)
    left join shva_price shva on date(l.block_timestamp) = date(shva.timestamp)
    left join {{ ref('dfk_item_to_gold') }} i2g on l.evm_contract_address = i2g.contract_address
    where {{ incremental_load_filter("block_timestamp") }}
    and l.tx_hash in ( select quest_tx from all_quest_rewards )
    and event_name = 'Transfer'
    order by block_timestamp asc
)

select * from final