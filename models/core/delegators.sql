{{
    config(
        materialized='incremental',
        unique_key='u_key',
        tags=['core'],
        cluster_by=['day_date']
    )
}}

with delegators_incremental as (
    select
        *
    from {{ ref('stg_delegators') }}
    where {{ incremental_load_filter_2('ingest_timestamp', 'day_date') }}
    
),


delegator as (
    select 
       day_date,
       d.value:"delegator-address"::variant as delegator_address,
       sum(d.value:amount::int)/ pow(10, 18) as total_amount_delegated,
       sum(u.value:amount::int) as total_amount_undelegated,
       sum(d.value:reward::int) as delegator_reward
from delegators_incremental,
lateral flatten(input => delegators_incremental.delegations) as d,
lateral flatten(input => d.value:undelegations) as u
group by 1,2

),

final as (
    select
        concat_ws('-', to_char(day_date, '%Y%m%d'), delegator_address) as u_key,
        *
    from delegator
)

select * from final
