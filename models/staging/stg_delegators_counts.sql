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
with
limits as(
    select
        validator_address as limit_validator_address,
        date_trunc('day', ingest_timestamp) as limit_day_date,
        max(ingest_timestamp) as limit_ingest_timestamp
    from {{ ref("stg_delegators") }}
    where {{ incremental_last_x_days("day_date", 2) }}
    group by 1,2
),
limit_join as (
    select
        *
    from limits as l
    left join {{ ref("stg_delegators") }} as orig
        on orig.validator_address=l.limit_validator_address
        and orig.ingest_timestamp=l.limit_ingest_timestamp
),
final as (
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
    from limit_join, Table(Flatten(delegations)) as fv
    where 1=1
    group by 1,2,3,4,5,6,7,8
)

select * from final
