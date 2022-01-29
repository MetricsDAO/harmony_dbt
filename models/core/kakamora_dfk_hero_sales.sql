{{ 
     config(
         materialized = 'incremental',
         unique_key = 'tx_hash',
         tags=['dfk', 'dfk_quest_rewards']
         cluster_by = ['block_timestamp']
     ) 
}}
with logs as (
    select 
        *
    from {{ ref('logs') }}
    where {{ incremental_load_filter("block_timestamp") }}
), hero_auction_txns as (
    SELECT 
        tx_hash,
        block_timestamp,
        java_hextoint(replace(topics[1]::string, '0x','' )) as hero_token_id,
        java_hextoint(substr(data, 3, 64)) as auction_id, -- TODO: Remove it
        java_hextoint(substr(data, 3+64, 64))::number / 1e18  as total_jewels,
        -1 as tax_jewels, -- TODO: Calculate it        
        '0x101010101010101010110'  as seller_address, -- TODO: Identify it!
        concat('0x',LTRIM(substr(data, 3+128, 64),'0')) as buyer_address,
        -1 as total_usd, -- TODO: Calculate it        
        -1 as tax_usd -- TODO: Calculate it        
    FROM logs
    WHERE event_removed = false
        and evm_contract_address = '0x13a65b9f8039e2c032bc022171dc05b30c3f2892'
        and topics[0]::string ='0xe40da2ed231723b222a7ba7da994c3afc3f83a51da76262083e38841e2da0982' -- AuctionSuccessful event
        and block_timestamp > '2021-12-20' -- TODO: Remove it
)
SELECT 
    tx_hash,
    block_timestamp,
    hero_token_id,
    auction_id,
    total_jewels,
    tax_jewels,
    total_usd,
    tax_usd,
    seller_address,
    buyer_address
FROM hero_auction_txns
ORDER BY block_timestamp desc -- TODO: Remove it
LIMIT 100 -- TODO: Remove it
