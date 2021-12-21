import json


f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

def replaceQuotes(buf):
    return buf.replace("'","")

for lpPool in y["data"]["pairs"]:
    print("union select '" + lpPool["id"] + "' as pool_address, '" + lpPool["token0"]["symbol"] + "-" + lpPool["token1"]["symbol"] + " LP" + "' as pool_name, '" + lpPool["token0"]["id"] + "' as token0, '" + lpPool["token1"]["id"] + "' as token1")