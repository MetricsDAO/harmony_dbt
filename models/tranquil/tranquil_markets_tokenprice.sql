{{
    config(
        materialized='view',
        unique_key="token_symbol||'-'||timestamp",
        tags=['core', 'defi', 'amm', 'lending']
        )
}}


with
final as (  
    select 'ONE' as token_symbol, * from tokenprice_one
    union all
    select 'stONE' as token_symbol, * from tokenprice_stone
    union all
    select '1WBTC' as token_symbol, * from tokenprice_btc
    union all
    select '1BTC' as token_symbol, * from tokenprice_btc
    union all
    select '1ETH' as token_symbol, * from tokenprice_eth
    union all
    select '1USDC' as token_symbol, * from tokenprice_usd
    union all
    select '1USDT' as token_symbol, * from tokenprice_usd
    union all
    select '1DAI' as token_symbol, * from tokenprice_usd
)


select * from final
    



