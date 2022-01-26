{{ config(materialized='table', tags=['playground', 'ant_staging']) }}

select *
from {{ ref('staging__ant_test_table') }}