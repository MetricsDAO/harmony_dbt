{{ config(materialized='view', tags=['playground', 'ant_views', 'ant_tokens']) }}

select
date_trunc('day',timestamp) as timestamp
,avg(price) as price
from harmony.dev.ant_token_prices
where token_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
group by 1
order by 1 desc