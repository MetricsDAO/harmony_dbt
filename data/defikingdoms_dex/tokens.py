import json

file = open("liquidity_pools.json")
data = json.loads(file.read())

dups = []

print("token_address,token_name,token_symbol,decimals")
for lpPool in data["data"]["pairs"]:
    if not (lpPool["token0"]["id"] in dups):
        print(lpPool["token0"]["id"]+","+lpPool["token0"]["name"]+","+lpPool["token0"]["symbol"]+","+lpPool["token0"]["decimals"])
        dups.append(lpPool["token0"]["id"])
        
    if not (lpPool["token1"]["id"] in dups):
        print(lpPool["token1"]["id"]+","+lpPool["token1"]["name"]+","+lpPool["token1"]["symbol"]+","+lpPool["token1"]["decimals"])
        dups.append(lpPool["token1"]["id"])

## Additional tables -- if you need it 
#if not ('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' in dups):
#    print("0x9edb3da18be4b03857f3d39f83e5c6aad67bc148,Golden Egg,TMP_DFKGOLDEGG,0)

if not ('0xa1f8b0e88c51a45e152934686270ddf4e3356278' in dups):
    print('0xa1f8b0e88c51a45e152934686270ddf4e3356278,Anti-Poison Potion,DFKANTPSN,0')

if not ('0x1771dec8d9a29f30d82443de0a69e7b6824e2f53' in dups):
    print('0x1771dec8d9a29f30d82443de0a69e7b6824e2f53,Anti-Blind Potion,DFKANTBLND,0')

if not ('0x7e120334d9affc0982719a4eacc045f78bf41c68' in dups):
    print('0x7e120334d9affc0982719a4eacc045f78bf41c68,Magic Resistance Potion,DFKMGCRSPTN,0')

if not ('0xfb03c364969a0bb572ce62b8cd616a7ddeb4c09a' in dups):
    print('0xfb03c364969a0bb572ce62b8cd616a7ddeb4c09a,Toughness Potion,DFKTFNSPTN,0')

if not ('0x872dd1595544ce22ad1e0174449c7ece6f0bb01b' in dups):
    print('0x872dd1595544ce22ad1e0174449c7ece6f0bb01b,Swiftness Potion,DFKSWFTPTN,0')

if not ('0x9678518e04fe02fb30b55e2d0e554e26306d0892' in dups):
    print('0x9678518e04fe02fb30b55e2d0e554e26306d0892,Blue Egg,DFKBLUEEGG,0')

if not ('0x6d605303e9ac53c59a3da1ece36c9660c7a71da5' in dups):
    print('0x6d605303e9ac53c59a3da1ece36c9660c7a71da5,Green Egg,DFKGREENEGG,0')
    
if not ('0x3db1fd0ad479a46216919758144fd15a21c3e93c' in dups):
    print('0x3db1fd0ad479a46216919758144fd15a21c3e93c,Yellow Egg,DFKYELOWEGG,0')
