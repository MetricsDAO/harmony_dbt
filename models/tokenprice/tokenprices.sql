{{
    config(
        materialized='incremental',
        unique_key="block_date||'-'||token_address",
        tags=['core', 'defi', 'tokenprice'],
        cluster_by=['block_date', 'token_address']
        )
}}

with 
stage as (
  select * from {{ ref('stg_tokenprice_from_swaps')}}
),

final as (
  SELECT
    block_date,
    token_address,
    token_symbol,
    usd_price,
    usd_volume,
    token_volume
  from stage
  where usd_volume >= 100
)

select * from final