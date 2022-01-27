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

#print("{{ config(materialized='table', unique_key=\"CONCAT_WS('-', token_address, token_name)\", tags=['playground', 'ant_labels', 'ant_tokens2']) }}")
print("token_address,token_name,token_symbol,decimals")
for lpPool in y["data"]["pairs"]:
    #print(lpPool["id"] + ":" + lpPool["token0"]["name"] + "-" + lpPool["token1"]["name"] + " LP")
    if (lpPool["token0"]["id"] in dups) == False:
        #print(doOnce("      ", "union ") + "select '" + lpPool["token0"]["id"] + "' as token_address, '" + replaceQuotes(lpPool["token0"]["name"]) + "' as token_name, '" + lpPool["token0"]["symbol"] + "' as token_symbol, " + lpPool["token0"]["decimals"] + " as decimals")
        print(lpPool["token0"]["id"]+","+lpPool["token0"]["name"]+","+lpPool["token0"]["symbol"]+","+lpPool["token0"]["decimals"])
        dups.append(lpPool["token0"]["id"])
        
    if (lpPool["token1"]["id"] in dups) == False:
        #print("union select '" + lpPool["token1"]["id"] + "' as token_address, '" + replaceQuotes(lpPool["token1"]["name"]) + "' as token_name, '" + lpPool["token1"]["symbol"] + "' as token_symbol, " + lpPool["token1"]["decimals"] + " as decimals")
        print(lpPool["token1"]["id"]+","+lpPool["token1"]["name"]+","+lpPool["token1"]["symbol"]+","+lpPool["token1"]["decimals"])
        dups.append(lpPool["token1"]["id"])

## Additional tables
#if ('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' in dups) == False:
#    print("union select '0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' as token_address, 'Golden Egg' as token_name, 'TMP_DFKGOLDEGG' as token_symbol, 0 as decimals")
#
#if ('0x6d605303e9ac53c59a3da1ece36c9660c7a71da5' in dups) == False:
#    print("union select '0x6d605303e9ac53c59a3da1ece36c9660c7a71da5' as token_address, 'Green Pet Egg' as token_name, 'TMP_DFKGRNEGG' as token_symbol, 0 as decimals")
#
#if ('0xac5c49ff7e813de1947dc74bbb1720c353079ac9' in dups) == False:
#    print("union select '0xac5c49ff7e813de1947dc74bbb1720c353079ac9' as token_address, 'Blue Stem' as token_name, 'TMP_DFKBLUESTEM' as token_symbol, 0 as decimals")
#
#if ('0xc0214b37fcd01511e6283af5423cf24c96bb9808' in dups) == False:
#    print("union select '0xc0214b37fcd01511e6283af5423cf24c96bb9808' as token_address, 'Milkweed' as token_name, 'TMP_DFKMILKWEED' as token_symbol, 0 as decimals")
#
#if ('0x19b9f05cde7a61ab7aae5b0ed91aa62ff51cf881' in dups) == False:
#    print("union select '0x19b9f05cde7a61ab7aae5b0ed91aa62ff51cf881' as token_address, 'Spiderfruit' as token_name, 'TMP_DFKSPIDERFRUIT' as token_symbol, 0 as decimals")
