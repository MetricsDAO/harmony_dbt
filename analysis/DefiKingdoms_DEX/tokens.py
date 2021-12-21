import json


f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

def replaceQuotes(buf):
    return buf.replace("'","")

for lpPool in y["data"]["pairs"]:
    #print(lpPool["id"] + ":" + lpPool["token0"]["name"] + "-" + lpPool["token1"]["name"] + " LP")
    if (lpPool["token0"]["id"] in dups) == False:
        print("union select '" + lpPool["token0"]["id"] + "' as token_address, '" + replaceQuotes(lpPool["token0"]["name"]) + "' as token_name, '" + lpPool["token0"]["symbol"] + "' as token_symbol, " + lpPool["token0"]["decimals"] + " as decimals")
        dups.append(lpPool["token0"]["id"])
        
    if (lpPool["token1"]["id"] in dups) == False:
        print("union select '" + lpPool["token1"]["id"] + "' as token_address, '" + replaceQuotes(lpPool["token1"]["name"]) + "' as token_name, '" + lpPool["token1"]["symbol"] + "' as token_symbol, " + lpPool["token1"]["decimals"] + " as decimals")
        dups.append(lpPool["token1"]["id"])