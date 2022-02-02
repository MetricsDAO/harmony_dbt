{{ 
    config(
        materialized='incremental',
        unique_key='day_date',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['day_date']
        )
}}


with 
daily_active_addresses as (
  select distinct user_address, day_date
    from (
      select from_address as user_address, date_trunc('day',block_timestamp) as day_date from {{ ref("txs") }}
      union all
      select to_address as user_address, date_trunc('day',block_timestamp) as day_date  from {{ ref("txs") }}
    )
),
final as (
    select 
        day_date, 
        count(1) as active_addresses
    from daily_active_addresses
    group by 1
)

select * from final