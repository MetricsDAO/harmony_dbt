{{ 
    config(
        materialized='table',
        tags=['metrics'],
        cluster_by=['day_date']
    )
}}

with all_min_addresses as (
  select user_address, min(min_timestamp) as min_min_timestamp
  from (
    select from_address as user_address, min(block_timestamp) as min_timestamp from {{ ref("txs") }}
    group by 1

    union all

    select to_address as user_address, min(block_timestamp) as min_timestamp  from {{ ref("txs") }}
    group by 1
  )
    group by 1
  ),
  
  final as (
      select
  date_trunc('day', min_min_timestamp) as day_date,
  count(1) as daily_new_address,
  sum(count(1)) over (order by day_date) as cummulative_count
  from all_min_addresses
  group by 1
  order by 1
  )

  select * from final
