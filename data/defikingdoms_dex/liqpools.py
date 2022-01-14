import json


f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

print("pool_address,pool_name,token0,token1")
for lpPool in y["data"]["pairs"]:
    print(lpPool["id"]+","+lpPool["token0"]["symbol"]+"-"+lpPool["token1"]["symbol"]+" LP"+","+lpPool["token0"]["id"]+","+lpPool["token1"]["id"])
