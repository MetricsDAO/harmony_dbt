{{ 
    config(
        materialized='incremental',
        unique_key = 'timestamp',
        incremental_strategy = 'delete+insert',
        tags=['tokenprice'],
        cluster_by=['timestamp']
    )
}}

with stage as (
    select
        block_date,
        usd_price,
        token_symbol
    from {{ ref("tokenprices") }}
    where {{ incremental_load_filter_2("block_date", "timestamp") }}
),

final as (
    select
        block_date as timestamp,
        usd_price as price
    from stage
    where token_symbol = 'WONE'
)

select * from final
