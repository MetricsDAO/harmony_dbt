{{ 
    config(
        materialized='incremental',
        unique_key='tx_id',
        incremental_strategy = 'delete+insert',
        tags=['dfk'],
        cluster_by=['block_timestamp']
        ) 
}}

with

level_up_txs_start as (
    select 
        tx_hash as tx_id,
        java_hextoint(substr(data,3+8,64))::integer as hero_id,
        block_timestamp,
        from_address as hero_owner
    from harmony.prod.txs
    where to_address = '0x0594d86b2923076a2316eaea4e1ca286daa142c1'
        and substr(data,0,10)= '0xfa863736'
),

sum_raw_level_ups as (
    select 
        block_timestamp,
        tx_id,
        eth_contract_address,
        sum(event_inputs:value) as amount
    from harmony.dev.ant_logs
    where tx_id in (select tx_id from level_up_txs_start)
        and event_emitted_name = 'Transfer'
    group by 1,2,3
),

final as (
    select 
        m.block_timestamp,
        m.tx_id,
        m.hero_id,
        m.hero_owner,
        srune.amount as rune_amount,
        sjewel.amount/pow(10,18) as jewel_amount,
        rune_amount * sruneprice.price as rune_price_usd,
        jewel_amount * sjewelprice.price as jewel_price_usd,
        rune_price_usd + jewel_price_usd as amount_usd
    from level_up_txs_start as m
    left join sum_raw_level_ups srune 
        on srune.tx_id = m.tx_id
        and srune.eth_contract_address = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286'
    left join sum_raw_level_ups sjewel
        on sjewel.tx_id = m.tx_id
        and sjewel.eth_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
    left join harmony.dev.tokenprice_jewel sjewelprice
        on date(sjewelprice.timestamp) = date(m.block_timestamp)
    left join harmony.dev.tokenprice_shvasrune sruneprice
        on date(sruneprice.timestamp) = date(m.block_timestamp)
    order by m.block_timestamp asc
  )
  
  select * from final