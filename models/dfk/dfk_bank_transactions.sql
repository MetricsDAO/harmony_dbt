{{
	config(
		materialized='incremental',
		unique_key='tx_hash',
		tags=['dfk'],
		cluster_by=['block_timestamp']
	)
}}

with banking_txs as (
    select
        tx_hash,
        block_timestamp,
        native_from_address as from_address,
        from_address as from_hex_address,
        case
            when data like '0xa59f3e0c%' then 'Deposit'
            when data like '0x67dfd4c9%' then 'Withdraw'
        end as type
    from {{ ref("txs") }} txs
    where to_address = '0xa9ce83507d872c5e1273e745abcfda849daa654f'
    and (data like '0xa59f3e0c%' or data like '0x67dfd4c9%')
    and status = true
	and {{ incremental_load_filter("block_timestamp") }}
),

token_amounts as (
    select
        banking_txs.tx_hash as tx_hash,
        sum(case evm_contract_address when '0x72cb10c6bfa5624dd07ef608027e366bd690048f' then event_inputs:value end) as jewel_amount,
        sum(case evm_contract_address when '0xa9ce83507d872c5e1273e745abcfda849daa654f' then event_inputs:value end) as xjewel_amount
    from banking_txs
    join {{ ref("logs") }} logs on banking_txs.tx_hash = logs.tx_hash
    where event_name = 'Transfer'
    group by 1
),

final as (
    select
        banking_txs.tx_hash as tx_hash,
        block_timestamp,
        from_address,
        from_hex_address,
        type,
        jewel_amount,
        xjewel_amount
    from banking_txs
    join token_amounts on banking_txs.tx_hash = token_amounts.tx_hash
)

select * from final
