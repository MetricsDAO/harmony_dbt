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
logs as (
    select
        *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("block_timestamp") }}
),
jewel_price as (
    select 
        *
    from {{ ref("tokenprice_jewel") }}
    where {{ incremental_last_x_days("timestamp", 3) }}
),
summon_tx as (
    select
        tx_hash,
        from_address
    from {{ ref("txs") }}
    where {{ incremental_load_filter("block_timestamp") }}
        and (
                to_address = '0x65dea93f7b886c33a78c10343267dd39727778c2' -- old summoning contract
                or to_address = '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355' -- new summoning contract
            )
        and (
                substr(data,0,10) = '0x4ea8a311' -- summonCrystal
                or substr(data,0,10) = '0xc2b40631' -- summonCrystalWithAuctionOld
        )
),
costs_to_summon AS (
    select 
        block_timestamp,
        evm_contract_address,
        event_inputs:value/pow(10,18)::number as amount,
        event_inputs:to::string as who,
        event_inputs:from::string as renter,
        tx_hash
    from logs
    where tx_hash in (select tx_hash from summon_tx)
        and event_name = 'Transfer'
        and evm_contract_address != '0x5f753dcdf9b1ad9aabc1346614d1f4746fd6ce5c'
        and who != '0xa9ce83507d872c5e1273e745abcfda849daa654f' -- xJewel
        and who != '0xa4b9a93013a5590db92062cf58d4b0ab4f35dbfb' -- Dev Fund
        and who != '0x3875e5398766a29c1b28cc2068a0396cba36ef99' -- Market Fund
        and who != '0x79f0d0670d17a89f509ad1c16bb6021187964a29' -- Founder Wallet
        and who != '0x000000000000000000000000000000000000dead' -- burn address
        and who != '0x0000000000000000000000000000000000000000' -- burn address
        and who != '0x5ca5bcd91929c7152ca577e8c001c9b5a185f568' -- quest reward pool
        and who != '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355' -- summoning contract 2
        and who != '0x65dea93f7b886c33a78c10343267dd39727778c2' -- summoning contract 1
),
final as (
    select 
        m.block_timestamp,
        m.amount as jewel_amount,
        m.who as user_address,
        stx.from_address as renter_address,
        m.tx_hash,
        jewel_amount * j.price as amount_usd
    from costs_to_summon as m
    left join summon_tx as stx
        on stx.tx_hash = m.tx_hash
    left join jewel_price j
        on date(j.timestamp) = date(m.block_timestamp)
)

select * from final
