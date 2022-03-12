{{ 
     config(
         materialized = 'incremental',
         unique_key = 'tx_hash',
         incremental_strategy = 'delete+insert',
         tags = ['dfk'],
         cluster_by = ['block_timestamp']
     ) 
}}

with
logs as (
    select 
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("block_timestamp") }}
),
auction_created as (
    select
        tx_hash,
        block_timestamp,
        concat('0x',LTRIM(substr(topics[1], 3, 64),'0')) as seller_address,
        java_hextoint(substr(data,3,64))::number as auction_id
    from {{ ref('logs') }} -- reverse lookup, need to look at all the data
    where topics[0]::string = '0x9a33d4a1b0a13cd8ff614a080df31b4b20c845e5cde181e3ae6f818f62b6ddde' -- auction created event
),
hero_auction_txns as (
    select 
        tx_hash,
        block_timestamp,
        java_hextoint(replace(topics[1]::string, '0x','' )) as hero_token_id,
        java_hextoint(substr(data, 3, 64)) as auction_id,
        java_hextoint(substr(data, 3+64, 64))::number / 1e18  as total_jewels,
        java_hextoint(substr(data, 3+64, 64))::number / 1e18 * 0.0375 as tax_jewels,
        concat('0x',LTRIM(substr(data, 3+128, 64),'0')) as buyer_address,
        total_jewels * jewel_price.price  as total_usd,
        tax_jewels * jewel_price.price as tax_usd
    from logs
    left join harmony.dev.tokenprice_jewel as jewel_price
        on date_trunc('day', block_timestamp) = jewel_price.timestamp
    where event_removed = false
        and evm_contract_address = '0x13a65b9f8039e2c032bc022171dc05b30c3f2892'
        and topics[0]::string ='0xe40da2ed231723b222a7ba7da994c3afc3f83a51da76262083e38841e2da0982' -- AuctionSuccessful event
),
final as (
    select
        auction_created.seller_address,
        hero_auction_txns.*
    from auction_created
    right join hero_auction_txns
        on hero_auction_txns.auction_id = auction_created.auction_id
)

select * from final
