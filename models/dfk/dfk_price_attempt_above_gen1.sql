    {{
    config(
        materialized='table',
        tags=['dfk']
        )
    }}

select
hero_info_class,
summons_left,
hero_info_generation,
hero_info_rarity,
min(total_jewels) as min_jewel,
max(total_jewels) as max_jewel,
avg(total_jewels) as avg_jewel,
median(total_jewels) as median_jewel,
mode(total_jewels) as mode_jewel,
sum(total_jewels * (current_date-block_timestamp::date)) / sum(current_date-block_timestamp::date) as tw_average,
count(total_jewels) as sample_size
from harmony.dev.dfk_last_30_days
where 1=1
and hero_info_class is not null
and hero_info_generation != 0
group by 1,2,3,4
having sample_size > 5