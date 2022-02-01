{{ 
    config(
        materialized='incremental',
        unique_key='day_date || validator_address',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['day_date']
        )
}}

-- TODO: this dbt script is slow, figure out a way to make it quicker. flatten takes up alot of time.
with final as (
    select
        day_date,
        validator_address,
        validator_identity,
        active_status,
        booted_status,
        delegations,
        total_delegation,
        total_delegator_count,
        count(fv.value:"delegator-address") as delegations_address_count,
        sum(fv.value:amount) as delegations_amount,
        count_if( fv.value:amount > 0 ) as delegations_active_delegations
    from {{ ref("stg_delegators") }}, Table(Flatten(delegations)) as fv
    where {{ incremental_load_filter("day_date") }}
    group by 1,2,3,4,5,6,7,8
)

select * from final