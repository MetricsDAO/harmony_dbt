{{
    config(
        materialized='incremental',
        unique_key='tx_hash',
        tags=['dfk'],
        cluster_by=['block_timestamp']
    )
}}

with

incremental_txs as (
    select *
    from {{ ref("txs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

incremental_logs as (
    select *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

banking_txs as (
    select
        tx_hash,
        block_timestamp,
        ingested_at,
        native_from_address,
        from_address,
        case
            when data like '0xa59f3e0c%' then 'Deposit'
            when data like '0x67dfd4c9%' then 'Withdraw'
        end as type
    from incremental_txs
    where to_address = '0xa9ce83507d872c5e1273e745abcfda849daa654f'
        and (data like '0xa59f3e0c%' or data like '0x67dfd4c9%')
        and status = true
),

token_amounts as (
    select
        banking_txs.tx_hash as tx_hash,
        sum(case evm_contract_address when '0x72cb10c6bfa5624dd07ef608027e366bd690048f' then event_inputs:value end) as jewel_amount,
        sum(case evm_contract_address when '0xa9ce83507d872c5e1273e745abcfda849daa654f' then event_inputs:value end) as xjewel_amount
    from banking_txs
    join incremental_logs as logs
        on banking_txs.tx_hash = logs.tx_hash
    where event_name = 'Transfer'
    group by 1
),

final as (
    select
        banking_txs.tx_hash as tx_hash,
        block_timestamp,
        ingested_at,
        native_from_address,
        from_address,
        type,
        jewel_amount / pow(10,18) as jewel_amount,
        xjewel_amount / pow(10,18) as xjewel_amount
    from banking_txs
    join token_amounts
        on banking_txs.tx_hash = token_amounts.tx_hash
)

select * from final
