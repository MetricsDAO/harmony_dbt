import json


file = open("liquidity_pools.json")
data = json.loads(file.read())

print("pool_address,pool_name,token0,token1")
for lpPool in data["data"]["pairs"]:
    print(lpPool["id"]+","+lpPool["token0"]["symbol"]+"-"+lpPool["token1"]["symbol"]+" LP"+","+lpPool["token0"]["id"]+","+lpPool["token1"]["id"])
