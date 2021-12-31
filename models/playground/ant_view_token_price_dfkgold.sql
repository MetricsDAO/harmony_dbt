{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date(timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7'
group by timestamp
order by timestamp desc