import json


f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

for lpPool in y["data"]["pairs"]:
    #print(lpPool["id"] + ":" + lpPool["token0"]["name"] + "-" + lpPool["token1"]["name"] + " LP")
    if (lpPool["token0"]["id"] in dups) == False:
        print(lpPool["token0"]["id"] + "::" + lpPool["token0"]["name"] + ":::" + lpPool["token0"]["symbol"] + "::::" + lpPool["token0"]["decimals"])
        dups.append(lpPool["token0"]["id"])
        
    if (lpPool["token1"]["id"] in dups) == False:
        print(lpPool["token1"]["id"] + "::" + lpPool["token1"]["name"] + ":::" + lpPool["token1"]["symbol"] + "::::" + lpPool["token1"]["decimals"])
        dups.append(lpPool["token1"]["id"])