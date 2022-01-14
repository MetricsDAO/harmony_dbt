import json

f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

print("token_address,token_name,token_symbol,decimals")
for lpPool in y["data"]["pairs"]:
    if (lpPool["token0"]["id"] in dups) == False:
        print(lpPool["token0"]["id"]+","+lpPool["token0"]["name"]+","+lpPool["token0"]["symbol"]+","+lpPool["token0"]["decimals"])
        dups.append(lpPool["token0"]["id"])
        
    if (lpPool["token1"]["id"] in dups) == False:
        print(lpPool["token1"]["id"]+","+lpPool["token1"]["name"]+","+lpPool["token1"]["symbol"]+","+lpPool["token1"]["decimals"])
        dups.append(lpPool["token1"]["id"])

## Additional tables -- if you need it 
#if ('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' in dups) == False:
#    print("0x9edb3da18be4b03857f3d39f83e5c6aad67bc148,Golden Egg,TMP_DFKGOLDEGG,0)

