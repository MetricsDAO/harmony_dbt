## files
1. liquidity_pools.json 
    - extracted from https://graph.defikingdoms.com/subgraphs/name/defikingdoms/dex/graphql 
    - only has 500-ish pairs for now (21-dec-2021)
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

``` python3 main.py > lptokens.sql ```

fix it in post.. using vscode