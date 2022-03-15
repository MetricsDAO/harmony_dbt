    {{
    config(
        materialized='table',
        tags=['dfk']
        )
    }}

            with
            table_sales as (
                    select * from harmony.dev.dfk_hero_sales
                    where block_timestamp > current_date - 60
            ),
            table_update as (
                    select * from harmony.dev.dfk_hero_updates
            ),
            sales as (
                select
                    block_timestamp,
                    hero_token_id as hero_id,
                    total_jewels
                from table_sales
            )
            
            select
                s.block_timestamp,
                s.hero_id,
                s.total_jewels,
                u.block_timestamp as u_time,
                u.hero_id as u_hero,
                u.summoning_info_maxsummons,
                u.summoning_info_maxsummons - summoning_info_summons as summons_left,
                u.hero_info_statgenes,
                u.hero_info_rarity,
                u.hero_info_generation,
                u.hero_info_class,
                u.hero_info_subclass,
                u.hero_state_level,
                u.hero_professions_mining,
                u.hero_professions_gardening,
                u.hero_professions_foraging,
                u.hero_professions_fishing
            from sales as s
            left join table_update u on u.hero_id = s.hero_id and u.block_timestamp < s.block_timestamp
            qualify row_number() over (partition by s.hero_id order by u.block_timestamp desc) = 1