{{ config(
    materialized = 'incremental',
    unique_key = 'block_id',
    tags = ['core']
) }}

SELECT
    block_id,
    block_timestamp,
    header :hash :: STRING AS block_hash,
    header :parent_hash :: STRING AS block_parent_hash,
    header :gas_limit AS gas_limit,
    header :gas_used AS gas_used,
    header :miner :: STRING AS miner,
    header :size AS SIZE,
    tx_count
<<<<<<< HEAD
FROM
    {{ deduped_blocks("harmony_blocks") }}
    -- Incrementaly load new data so that we don't do a full refresh each time
    -- we run `dbt run` see the macro `macros/incremental_utils.sql`
    -- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
WHERE
    {{ incremental_load_filter("block_timestamp") }}
    -- hey
    -- adding stuff
=======
from {{ deduped_blocks("harmony_blocks") }}
-- Incrementaly load new data so that we don't do a full refresh each time
-- we run `dbt run` see the macro `macros/incremental_utils.sql` 
-- or https://docs.getdbt.com/docs/building-a-dbt-project/building-models/configuring-incremental-models
where {{ incremental_load_filter("block_timestamp") }}
-- test
-- another test, yo!
>>>>>>> main
