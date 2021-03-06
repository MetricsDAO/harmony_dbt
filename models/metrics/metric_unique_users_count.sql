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
        count(from_address) as unique_users_count,
        sum(unique_users_count) over (partition by metric_period order by metric_date) as unique_users_cumulative
    from min_address
    group by 1, 2

),

hourly as (

    select
        date_trunc('hour', min_timestamp) as metric_date,
        'hourly' as metric_period,
        count(from_address) as unique_users_count,
        sum(unique_users_count) over (partition by metric_period order by metric_date) as unique_users_cumulative
    from min_address
    group by 1, 2

),

minute as (

    select
        date_trunc('minute', min_timestamp) as metric_date,
        'minute' as metric_period,
        count(from_address) as unique_users_count,
        sum(unique_users_count) over (partition by metric_period order by metric_date) as unique_users_cumulative
    from min_address
    group by 1, 2

),

final as (
    select * from daily
    union all
    select * from hourly
    union all
    select * from minute
)

select * from final
