{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date_trunc('day',timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x3a4edcf3312f44ef027acfd8c21382a5259936e7'
group by 1
order by 1 desc