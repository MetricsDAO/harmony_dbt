{{ 
    config(
        materialized='incremental',
        unique_key = 'timestamp',
        incremental_strategy = 'delete+insert',
        tags=['tokenprice'],
        cluster_by=['timestamp']
    )
}}

with

-- faux table to match other market pricing lookups
final as (
    select 
        timestamp,
        1 as price
    from tokenprice_one
)

select * from final
