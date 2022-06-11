{{ 
    config(
        materialized='table',
        tags=['metrics'],
        cluster_by=['day_date']
    )
}}

with events as (
select
    block_timestamp,
    ingested_at,
    event_name,
    event_inputs:_from::string as mint,
    event_inputs:_to::string as burn
from
    {{ ref("logs") }},
lateral flatten( input => logs.topics ) f
where f.value='0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62' and event_name ='TransferSingle'
),

mint as (
select
    date_trunc('day', block_timestamp) as day_date,
    'mint' as event,
    count(*) as daily_count
from
    events
where mint='0x0000000000000000000000000000000000000000'
group by 1,2
),

burn as (
select
    date_trunc('day', block_timestamp) as day_date,
    'burn' as event,
    count(*) as daily_count
from
    events
where burn='0x0000000000000000000000000000000000000000'
group by 1,2
),

final as (
select * from mint
union all
select * from burn
)

select * from final