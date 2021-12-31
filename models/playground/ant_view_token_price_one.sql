{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date_trunc('day',timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a'
group by 1
order by 1 desc