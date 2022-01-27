{{ config(materialized='table', tags=['playground', 'ant_staging']) }}
select 1 as only_entry