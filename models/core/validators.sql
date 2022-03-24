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
	where {{ incremental_load_filter('ingest_timestamp') }}
),

latest_day_timestamps as (
    select
        max(ingest_timestamp) as ingest_timestamp,
        validator_address
    from delegators_incremental
    group by day_date, validator_address
),

latest_day_flat_delegations as (
    select
        value,
        ingest_timestamp,
        validator_address
    from delegators_incremental
	natural join latest_day_timestamps
	inner join lateral flatten(input => delegations)
),

rewards as (
    select
        ingest_timestamp,
        validator_address,
        sum(value:reward) as amount
    from latest_day_flat_delegations
    group by ingest_timestamp, validator_address
),

undelegations as (
    select
        ingest_timestamp,
        validator_address,
        sum(ifnull(flat_undelegations.value:amount, 0)) as amount
    from latest_day_flat_delegations
	inner join lateral flatten(input => value:undelegations, outer => true) flat_undelegations
    group by ingest_timestamp, validator_address
),

totals as (
    select
        ingest_timestamp,
        validator_address,
        rewards.amount as total_one_rewarded,
        undelegations.amount as total_one_undelegated
    from rewards join undelegations
    on rewards.ingest_timestamp = undelegations.ingest_timestamp
    and rewards.validator_address = undelegations.validator_address
),

validators as (
	select
		day_date,
		validator_address,
		js_onetohex(validator_address) as validator_hex_address,
		validator_identity,
		active_status,
		booted_status,
		total_delegation as total_one_delegated,
		ifnull(total_one_rewarded, 0) as total_one_rewarded,
		ifnull(total_one_undelegated, 0) as total_one_undelegated
	from delegators_incremental
	join totals 
	on delegators_incremental.ingest_timestamp = totals.ingest_timestamp
	and delegators_incremental.validator_address = totals.validator_address
),

final as (
	select
		concat_ws('-', to_char(day_date, '%Y%m%d'), validator_address) as u_key,
		*
	from validators
)

select * from final
