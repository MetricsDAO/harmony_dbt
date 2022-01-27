{{ 
    config(
        materialized='table',
        tags=['metrics'],
        cluster_by=['metric_date']
    )
}}

with

min_address as (

    select 
        from_address,
        min(block_timestamp) as min_timestamp
    from {{ ref("txs") }}
    group by 1

),

daily as (

    select
        date_trunc('day', min_timestamp) as metric_date,
        'daily' as metric_period,
        count(from_address) as unique_users_count
    from min_address
    group by 1

),

hourly as (

    select
        date_trunc('hour', min_timestamp) as metric_date,
        'hourly' as metric_period,
        count(from_address) as unique_users_count
    from min_address
    group by 1

),

minute as (

    select
        date_trunc('minute', min_timestamp) as metric_date,
        'minute' as metric_period,
        count(from_address) as unique_users_count
    from min_address
    group by 1

),

final as (
    select * from daily
    union all
    select * from hourly
    union all
    select * from minute
)

select * from final
