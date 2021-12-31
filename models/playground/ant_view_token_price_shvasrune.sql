{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date(timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x66f5bfd910cd83d3766c4b39d13730c911b2d286'
group by timestamp
order by timestamp desc