{{ 
    config(
        materialized='incremental',
        unique_key='ingest_timestamp || token || srcToken',
        incremental_strategy = 'delete+insert',
        tags=['core'],
        cluster_by=['ingest_timestamp']
        )
}}

-- https://github.com/DefiLlama/DefiLlama-Adapters/blob/main/projects/anyswap/index.js

with

source as (
    select 
        ingest_timestamp,
        try_parse_json(ingest_data) as parsed_data
    from harmony.dev.ant_ingest
    where {{ incremental_load_filter("ingest_timestamp") }}
),

final as (
    select 
        ingest_timestamp,
        flattened_data.value:chainId::string as chainId,
        flattened_data.value:srcChainId::string as srcChainId,
        flattened_data.value:token::string as token,
        flattened_data.value:srcToken::string as srcToken,
        flattened_data.value:symbol::string as symbol,
        flattened_data.value:decimals::integer as decimals,
        flattened_data.value:name::string as name,
        flattened_data.value:depositAddr::string as depositAddr,
        flattened_data.value:isProxy::integer as isProxy,
        flattened_data.value:DelegateToken::string as DelegateToken,
        flattened_data.value:price::float as price,
        flattened_data.value:sortid::integer as sortid,
        flattened_data.value:logoUrl::string as logoUrl,
        flattened_data.value:type::string as type,
        flattened_data.value:label::string as label,
        flattened_data.value:balance::string as balance,
        TRY_TO_DECIMAL(flattened_data.value:tvl::string) as tvl,
        TRY_TO_DECIMAL(flattened_data.value:amount::string)as amount,
        flattened_data.value:underlying::string as underlying
    from source, Table(Flatten(parsed_data:data:bridgeList)) as flattened_data
    where parsed_data is not null
        and parsed_data:type = 'multichain_ingest'
)

select * from final