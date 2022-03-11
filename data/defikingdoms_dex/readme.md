## Last Update
11-mar-2022

## Operational steps
1. Go to http://graph4.defikingdoms.com/subgraphs/name/defikingdoms/dex/graphql
2. Extract the data using this graphql snippet
```
{
  pairs (first: 1000)
  {
    token0 {
      id
      name
      symbol
      decimals
    }
    token1 {
      id
      name
      symbol
      decimals
    }
    id
    
  }
}
```
3. Paste the output into `liquidity_pools.json`
4. `sh run.sh`
5. You should see dfk_tokens and dfk_dex_lp_labels.csv updated

## Input files
1. liquidity_pools.json 
    - extracted from http://graph4.defikingdoms.com/subgraphs/name/defikingdoms/dex/graphql 
    - only has 750-ish pairs for now (11-mar-2022)
```
{
  pairs (first: 1000)
  {
    token0 {
      id
      name
      symbol
      decimals
    }
    token1 {
      id
      name
      symbol
      decimals
    }
    id
    
  }
}
```

## Output files
1. dfk_dex_lp_labels.csv
- made from liqpools.py

2. dfk_tokens.csv
- made from tokens.py

