{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date(timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04'
group by timestamp
order by timestamp desc