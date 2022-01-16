{{
    config(
        materialized='table',
        unique_key='pool_address',
        tags=['core', 'liquidity_pools'],
        cluster_by=['pool_address']
        )
}}

with

dfk_lp as (
    select
        *
    from {{ ref('dfk_dex_lp_labels') }}
),

-- this is an example of adding new protocols
tranq_lp as (
    -- this is an example of renaming columns, make sure the columns are in the right order
    select
        POOL_ADDRESS as pool_address,
        POOL_NAME as pool_name,
        TOKEN0 as token0,
        TOKEN1 as token1
    from {{ ref('dfk_dex_lp_labels') }}
    where 1=0 -- to select nothing for now
),

final as (

    select
        * 
    from dfk_lp

    union

    select
        * 
    from tranq_lp
)

select * from final
