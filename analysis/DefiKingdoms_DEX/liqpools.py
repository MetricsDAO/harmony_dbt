import json


f = open('liquidity_pools.json')
y = json.loads(f.read())

dups = []

def replaceQuotes(buf):
    return buf.replace("'","")

doOnceFlag = True
def doOnce(firstTime, repeatedTimes):
    global doOnceFlag
    if doOnceFlag == True:
        doOnceFlag = False
        return firstTime
    return repeatedTimes

#print("{{ config(materialized='table', unique_key=\"CONCAT_WS('-', pool_address, pool_name)\", tags=['playground', 'ant_labels', 'ant_dex_lp_labels']) }}")
print("pool_address,pool_name,token0,token1")
for lpPool in y["data"]["pairs"]:
    #print(doOnce("      ","union ") + "select '" + lpPool["id"] + "' as pool_address, '" + lpPool["token0"]["symbol"] + "-" + lpPool["token1"]["symbol"] + " LP" + "' as pool_name, '" + lpPool["token0"]["id"] + "' as token0, '" + lpPool["token1"]["id"] + "' as token1")
    print(lpPool["id"]+","+lpPool["token0"]["symbol"]+"-"+lpPool["token1"]["symbol"]+" LP"+","+lpPool["token0"]["id"]+","+lpPool["token1"]["id"])
