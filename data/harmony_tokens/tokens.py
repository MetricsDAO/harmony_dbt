import json

file = open("tokens.json")
data = json.loads(file.read())

print("token_address,token_name,token_symbol,decimals")
for lpPool in data:
    line = lpPool["address"]+","+lpPool["name"]+","+lpPool["symbol"]+","+str(lpPool["decimals"])
    print(line)

## Additional tables -- if you need it 
#print("0x9edb3da18be4b03857f3d39f83e5c6aad67bc148,Golden Egg,TMP_DFKGOLDEGG,0)
