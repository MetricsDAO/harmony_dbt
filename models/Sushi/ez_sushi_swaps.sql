{{ config(
  materialized = 'incremental',
  persist_docs ={ "relation": true,
  "columns": true },
  unique_key = 'log_id',
  cluster_by = ['block_timestamp::DATE']
) }}


with 
swap_without_prices as 
(    
select 
se.block_timestamp, 
se.block_id as block_number,
se.tx_hash, 
se.pool_address,
CASE  wHEN se.amount0In <> 0 and se.amount1In <> 0  THEN amount1In / power(10, token1.decimals ) :: FLOAT
      WHEN se.amount0In <> 0 THEN se.amount0In / power(10, token0.decimals)::float
      WHEN se.amount1In <> 0 THEN se.amount1In/ power(10, token1.decimals)::float
      END AS amount_in,
CASE 
      WHEN se.amount0Out <> 0 THEN se.amount0Out/ power(10, token0.decimals)::float
      WHEN se.amount1Out <> 0 THEN se.amount1Out/ power(10, token1.decimals)::float
      END as amount_out,
se.from_address as sender,
se.LOG_ID,
se.event_index,
CASE 
    WHEN se.amount0In <> 0 AND se.amount1In <> 0 THEN token1_address
    WHEN se.amount0In <> 0 THEN token0_address
    WHEN se.amount1In <> 0 THEN token1_address
    END AS token_In,
CASE 
    WHEN se.amount0Out <> 0 THEN token0_address
    WHEN se.amount1Out <> 0 THEN TOKEN1_ADDRESS
    END AS token_out,
CASE 
    WHEN se.amount0In <> 0 AND se.amount1In <> 0 THEN token1_symbol
    WHEN se.amount0In <> 0 THEN TOKEN0_SYMBOL
    WHEN se.amount1In <> 0 THEN token1_symbol
    END AS symbol_In,
CASE 
    WHEN se.amount0Out <> 0 THEN token0_symbol
    WHEN se.amount1Out <> 0 THEN token1_symbol
    END AS symbol_out,  
se.TO_ADDRESS as tx_to
from {{ ref('swaps') }} se --27,288,348
left join {{ ref('tokens') }} token0
on se.token0_address = token0.token_address
left join {{ ref('tokens') }} token1
on se.TOKEN1_ADDRESS = token1.TOKEN_ADDRESS --27,288,348
where 1 = 1

{% if is_incremental() %}
AND block_timestamp >= (
    SELECT
        MAX(block_timestamp) :: DATE - 2
    FROM
        {{ this }}
)
{% endif %}
),


 
    

ETH_prices as
( select token_address,
        hour,
        symbol,
        avg(price) as price  
   from         {{ source(
            'ethereum_db_sushi',
            'FACT_HOURLY_TOKEN_PRICES'
        ) }}

    WHERE
        1 = 1

{% if is_incremental() %}
AND HOUR :: DATE IN (
    SELECT
        DISTINCT block_timestamp :: DATE
    FROM
        swap_without_prices
)
{% else %}
    AND HOUR :: DATE >= '2020-05-05'
{% endif %}

group by token_address,
         hour,
         symbol),
         


Harmony_Eth_crosstab as
(select 
 name, 
 symbol, 
max (case 
     when platform_id = 'harmony-shard-0' then token_address 
    else '' end) as harmony_address, 
max (case 
    when platform = 'ethereum' then token_address 
        else '' end) as eth_address
from {{ source(
            'symbols_cross_tab',
            'MARKET_ASSET_METADATA'
        ) }}
group by 1,2
having harmony_address <> '' and eth_address <> ''
order by 1,2 
),

Harmony_prices as 
(select 
ep.token_address,
ep.hour,
ep.symbol,
ep.price,
hec.harmony_Address as harmony_address
from Eth_prices ep
left join Harmony_Eth_crosstab hec
on ep.token_address = hec.eth_Address 
) 

select 
wp.block_timestamp, 
wp.block_number,
wp.tx_hash, 
wp.pool_address,
'Sushiswap' as platform,
wp.event_index,
wp.amount_in,
wp.amount_out,
wp.sender,
wp.LOG_ID,
wp.token_In,
wp.token_out,
wp.symbol_In,
wp.symbol_out,  
wp.tx_to,
wp.amount_in * pIn.price as amount_in_usd,
wp.amount_out * pOut.price as amount_out_usd    
from swap_without_prices wp
left join Harmony_prices pIn
    on    lower(token_In) = lower(pIn.harmony_address)
    and   date_trunc('hour',wp.block_timestamp) = pIn.hour
left join Harmony_prices pOut
    on    lower(token_out) = lower(pOut.harmony_address)
    and   date_trunc('hour',wp.block_timestamp) = pOut.hour --27,288,348
where pool_address in (select token_address 
                        from MDAO_HARMONY.PROD.TOKENS
                        where token_name = 'SushiSwap LP Token')
                        











