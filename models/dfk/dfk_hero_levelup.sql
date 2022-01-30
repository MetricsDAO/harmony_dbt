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

level_up_txs_start as (
    select 
        tx_hash,
        java_hextoint(substr(data,3+8,64))::integer as hero_id,
        block_timestamp,
        from_address as hero_owner
    from {{ ref("txs") }}
    where to_address = '0x0594d86b2923076a2316eaea4e1ca286daa142c1'
        and substr(data,0,10)= '0xfa863736'
),

sum_raw_level_ups as (
    select 
        block_timestamp,
        tx_hash,
        evm_contract_address,
        sum(event_inputs:value) as amount
    from {{ ref("logs") }}
    where tx_hash in (select tx_hash from level_up_txs_start)
        and event_name = 'Transfer'
    group by 1,2,3
),

final as (
    select 
        m.block_timestamp,
        m.tx_hash,
        m.hero_id,
        m.hero_owner,
        srune.amount as rune_amount,
        sjewel.amount/pow(10,18) as jewel_amount,
        rune_amount * sruneprice.price as rune_price_usd,
        jewel_amount * sjewelprice.price as jewel_price_usd,
        rune_price_usd + jewel_price_usd as amount_usd
    from level_up_txs_start as m
    left join sum_raw_level_ups srune 
        on srune.tx_hash = m.tx_hash
        and srune.evm_contract_address = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286'
    left join sum_raw_level_ups sjewel
        on sjewel.tx_hash = m.tx_hash
        and sjewel.evm_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
    left join harmony.dev.tokenprice_jewel sjewelprice
        on date(sjewelprice.timestamp) = date(m.block_timestamp)
    left join harmony.dev.tokenprice_shvasrune sruneprice
        on date(sruneprice.timestamp) = date(m.block_timestamp)
    order by m.block_timestamp asc
  )
  
  select * from final