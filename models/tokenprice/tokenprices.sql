{{
    config(
        materialized='incremental',
        unique_key="key",
        incremental_strategy = 'delete+insert',
        tags=['core', 'defi', 'tokenprice'],
        cluster_by=['block_date', 'token_address']
        )
}}

with 
stage as (
  select * from {{ ref('stg_tokenprice_from_swaps')}}
  where {{ incremental_last_x_days("block_date", 3) }}
),

final as (
  select
    key,
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
