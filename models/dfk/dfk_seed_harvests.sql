{{
    config(
        materialized='incremental',
        unique_key='tx_hash',
        tags=['dfk'],
        cluster_by=['block_timestamp']
    )
}}

with incremental_txs as (
    select *
    from {{ ref("txs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

incremental_logs as (
    select *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("ingested_at") }}
),

harvest_txs as (
    select
        *
    from incremental_txs
    where to_address = '0xdb30643c71ac9e2122ca0341ed77d09d5f99f924'
      and data like '0x5eac6239%'
      and status = true
),

harvest_events as (
    select
        incremental_logs.tx_hash as tx_hash,
        event_inputs,
        event_name,
        from_address
    from incremental_logs
    join harvest_txs
      on incremental_logs.tx_hash = harvest_txs.tx_hash
),

jewel_amounts as (
    select
        tx_hash,
        sum(event_inputs:LockAmount) as jewel_locked,
        sum(event_inputs:value) as jewel_reward
    from harvest_events
    where (event_name = 'Lock' and event_inputs:LockedAddress = from_address)
       or (event_name = 'Transfer' and event_inputs:to = from_address)
    group by 1
),

final as (
    select
        block_timestamp,
        ingested_at,
        block_number,
        floor((block_number - 16350367) / 302400) + 1 as garden_epoch,
        native_from_address,
        from_address,
        harvest_txs.tx_hash as tx_hash,
        jewel_locked / pow(10, 18) as jewel_locked,
        (jewel_reward - jewel_locked) / pow(10, 18) as jewel_unlocked
    from harvest_txs
    join jewel_amounts
      on harvest_txs.tx_hash = jewel_amounts.tx_hash
)

select * from final
