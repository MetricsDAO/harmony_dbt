{{
    config(
        materialized='table',
        unique_key='token_address',
        tags=['core', 'tokens'],
        cluster_by=['token_address']
        )
}}

with

dfk_tokens as (
    select
        *
    from {{ ref('dfk_tokens') }}
),

harmony_explorer_tokens as (
    select
        *
    from {{ ref('harmony_explorer_tokens') }}
),

backfill_tokens as (
    select
        *
    from {{ ref('backfill_tokens_data') }}
    where token_address not in 
        (select token_address from dfk_tokens)
    and token_address not in 
        (select token_address from harmony_explorer_tokens)
),

-- this is an example of adding new protocols
tranq_tokens as (
    -- this is an example of renaming columns, make sure the columns are in the right order
    select
        TOKEN_ADDRESS as token_address,
        TOKEN_NAME as token_name,
        TOKEN_SYMBOL as token_symbol,
        DECIMALS as decimals
    from {{ ref('dfk_tokens') }}
    where 1=0 -- to select nothing for now
),

final as (

    select
        * 
    from dfk_tokens
    -- this is used to filter duplicate / problematic tokens from the dfk list.
    where token_address not in (select token_address from harmony_explorer_tokens)

    union

    select
        * 
    from harmony_explorer_tokens

    union

    select
        * 
    from backfill_tokens

    union

    select
        * 
    from tranq_tokens
)

select * from final
