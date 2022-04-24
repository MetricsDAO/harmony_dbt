{{ 
    config(
        materialized='table',
        tags=['metrics'],
        cluster_by=['metric_date']
    )
}}

with

daily as (
    select 
        date_trunc('day', block_timestamp) as metric_date,
        'daily' as metric_period,
        count( distinct from_address ) as txs_count_from,
        count( distinct to_address ) as txs_count_to
    from {{ ref("txs") }}
    group by 1, 2
),

hourly as (
    select 
        date_trunc('hour', block_timestamp) as metric_date,
        'hourly' as metric_period,
        count( distinct from_address ) as txs_count_from,
        count( distinct to_address ) as txs_count_to
    from {{ ref("txs") }}
    group by 1, 2
),

minute as (
    select 
        date_trunc('minute', block_timestamp) as metric_date,
        'minute' as metric_period,
        count( distinct from_address ) as txs_count_from,
        count( distinct to_address ) as txs_count_to
    from {{ ref("txs") }}
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
