{{ 
    config(
        materialized='incremental',
        unique_key = 'metric_date || metric_period',
        incremental_strategy = 'delete+insert',
        tags=['metrics'],
        cluster_by=['metric_date']
    )
}}

with

daily as (
    select 
        date_trunc('day', block_timestamp) as metric_date,
        'daily' as metric_period,
        count(distinct miner) as miner_count
    from {{ ref("blocks") }}
    where {{ incremental_last_x_days("block_timestamp", 3) }}
    group by 1, 2
),

hourly as (
    select 
        date_trunc('hour', block_timestamp) as metric_date,
        'hourly' as metric_period,
        count(distinct miner) as miner_count
    from {{ ref("blocks") }}
    where {{ incremental_last_x_days("block_timestamp", 3) }}
    group by 1, 2
),

minute as (
    select 
        date_trunc('minute', block_timestamp) as metric_date,
        'minute' as metric_period,
        count(distinct miner) as miner_count
    from {{ ref("blocks") }}
    where {{ incremental_last_x_days("block_timestamp", 3) }}
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
