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

src_logs_lp as (
    select 
        event_inputs:pair::string as pool_address,
        '' as pool_name,
        event_inputs:token0::string as token0,
        event_inputs:token1::string as token1
    from {{ ref('logs') }} 
    where event_name = 'PairCreated'
),

logs_lp as (
    select
        pool_address,
        t0.token_symbol || '-' || t1.token_symbol || ' LP' as pool_name, -- "TOKEN0-TOKEN1 LP"
        token0,
        token1
    from src_logs_lp p
    inner join {{ ref('tokens') }} as t0
        on p.token0 = t0.token_address
    inner join {{ ref('tokens') }} as t1
        on p.token1 = t1.token_address
    where p.pool_address not in (select pool_address from dfk_lp)
),

backfill_from_swaps as (
    select
        *
    from {{ ref('backfill_pools_data') }}
    where pool_address not in (select pool_address from logs_lp)
        and pool_address not in (select pool_address from dfk_lp)
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

viperswap_lp as (
    select
        *
    from {{ ref('viperswap_liquidity_pools') }}
),

dfk_lp as (
    select
        *
    from {{ ref('dfk_liquidity_pools') }}
),

final as (

    select
        * 
    from dfk_lp

    union

    select
        *
    from logs_lp

    union

    select
        *
    from backfill_from_swaps

    union

    select
        * 
    from tranq_lp

    union

    select
        * 
    from viperswap_lp

    union

    select
        * 
    from dfk_lp
)

select * from final
