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

if not ('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' in dups):
    print('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148,Golden Egg,DFKGOLDEGG,0')

if not ('0x27dc6aaad95580edf25f8b9676f1b984e09e413d' in dups):
    print('0x27dc6aaad95580edf25f8b9676f1b984e09e413d,Atonement Crystal,DFKATONECR,0')

if not ('0x1f3f655079b70190cb79ce5bc5ae5f19daf2a6cf' in dups):
    print('0x1f3f655079b70190cb79ce5bc5ae5f19daf2a6cf,Lesser Atonement Crystal,DFKLATONECR,0')

if not ('0x6d4f4bc32df561a35c05866051cbe9c92759da29' in dups):
    print('0x6d4f4bc32df561a35c05866051cbe9c92759da29,Lesser Chaos Stone,DFKLCHSST,0')

if not ('0x17f3b5240c4a71a3bbf379710f6fa66b9b51f224' in dups):
    print ('0x17f3b5240c4a71a3bbf379710f6fa66b9b51f224,Greater Atonement Crystal,DFKGATONECR,0')

if not ("0xab464901afbc61bac440a97fa568ac42885da58b" in dups):
    print("0xab464901afbc61bac440a97fa568ac42885da58b,\"Lesser Might Crystal\",DFKLMGHTCR,0")

if not ("0xb368f69be6eda74700763672aeb2ae63f3d20ae6" in dups):
    print("0xb368f69be6eda74700763672aeb2ae63f3d20ae6,\"Might Crystal\",DFKMGHTCR,0")

if not ("0x39927a2cee5580d63a163bc402946c7600300373" in dups):
    print("0x39927a2cee5580d63a163bc402946c7600300373,\"Lesser Finesse Crystal\",DFKLFINCR,0")

if not ("0xc6a58efc320a7afdb1cd662eaf6de10ee17103f2" in dups):
    print("0xc6a58efc320a7afdb1cd662eaf6de10ee17103f2,\"Finesse Crystal\",DFKFINCR,0")

if not ("0xf5c26f2f34e9245c3a9ea0b0e7ea7b33e6404da0" in dups):
    print("0xf5c26f2f34e9245c3a9ea0b0e7ea7b33e6404da0,\"Lesser Swiftness Crystal\",DFKLSWFTCR,0")

if not ("0x5d7f20e3b0f1406bf038175218ea7e9b4838908c" in dups):
    print("0x5d7f20e3b0f1406bf038175218ea7e9b4838908c,\"Swiftness Crystal\",DFKSWFTCR,0")

if not ("0x0d8403e47445db9e316e36f476dacd5827220bdd" in dups):
    print("0x0d8403e47445db9e316e36f476dacd5827220bdd,\"Lesser Vigor Crystal\",DFKLVGRCR,0")

if not ("0xbba50bd111dc586fd1f2b1476b6ec505800a3fd0" in dups):
    print("0xbba50bd111dc586fd1f2b1476b6ec505800a3fd0,\"Vigor Crystal\",DFKVGRCR,0")

if not ("0x3017609b9a59b77b708d783835b6ff94a3d9e337" in dups):
    print("0x3017609b9a59b77b708d783835b6ff94a3d9e337,\"Lesser Fortitude Crystal\",DFKLFRTICR,0")

if not ("0x603919aeb55eb13f9cde94274fc54ab2bd2dece7" in dups):
    print("0x603919aeb55eb13f9cde94274fc54ab2bd2dece7,\"Fortitude Crystal\",DFKFRTICR,0")

if not ("0x17ff2016c9eccfbf4fc4da6ef95fe646d2c9104f" in dups):
    print("0x17ff2016c9eccfbf4fc4da6ef95fe646d2c9104f,\"Lesser Wit Crystal\",DFKLWITCR,0")

if not ("0x3619fc2386fbbc19ddc39d29a72457e758cfad69" in dups):
    print("0x3619fc2386fbbc19ddc39d29a72457e758cfad69,\"Wit Crystal\",DFKWITCR,0")

if not ("0xc63b76f710e9973b8989678eb16234cfadc8d9db" in dups):
    print("0xc63b76f710e9973b8989678eb16234cfadc8d9db,\"Lesser Insight Crystal\",DFKLINSCR,0")

if not ("0x117e60775584cdfa4f414e22b075f31cc9c3207c" in dups):
    print("0x117e60775584cdfa4f414e22b075f31cc9c3207c,\"Insight Crystal\",DFKINSCR,0")

if not ("0x13af184aea970fe79e3bb7a1b0b156b195fb1f40" in dups):
    print("0x13af184aea970fe79e3bb7a1b0b156b195fb1f40,\"Lesser Fortune Crystal\",DFKLFRTUCR,0")

if not ("0x6d777c64f0320d8a5b31be0fdeb694007fc3ed45" in dups):
    print("0x6d777c64f0320d8a5b31be0fdeb694007fc3ed45,\"Fortune Crystal\",DFKFRTUCR,0")

if not ("0xe4e7c0c693d8a7fc159776a993495378705464a7" in dups):
    print("0xe4e7c0c693d8a7fc159776a993495378705464a7,\"Lesser Might Stone\",DFKLMGHTST,0")

if not ("0xe7f6ea1ce7bbebc9f2cf080010dd938d2d8d8b1b" in dups):
    print("0xe7f6ea1ce7bbebc9f2cf080010dd938d2d8d8b1b,\"Might Stone\",DFKMGHTST,0")

if not ("0xbb5614d466b77d50dded994892dfe6f0aca4eebb" in dups):
    print("0xbb5614d466b77d50dded994892dfe6f0aca4eebb,\"Lesser Finesse Stone\",DFKLFINST,0")

if not ("0xd0b689cb5de0c15792aa456c89d64038c1f2eedc" in dups):
    print("0xd0b689cb5de0c15792aa456c89d64038c1f2eedc,\"Finesse Stone\",DFKFINST,0")

if not ("0xd9a8abc0ce1adc23f1c1813986c9a9c21c9e7510" in dups):
    print("0xd9a8abc0ce1adc23f1c1813986c9a9c21c9e7510,\"Lesser Swiftness Stone\",DFKLSWFTST,0")

if not ("0x08f362517ad4119d93bbcd20825c2e4119abb495" in dups):
    print("0x08f362517ad4119d93bbcd20825c2e4119abb495,\"Swiftness Stone\",DFKSWFTST,0")

if not ("0xb00cbf5cd5e7b321436c2d3d8078773522d2f073" in dups):
    print("0xb00cbf5cd5e7b321436c2d3d8078773522d2f073,\"Lesser Vigor Stone\",DFKLVGRST,0")

if not ("0x9df75917ac9747b4a70fa033e4b0182d85b62857" in dups):
    print("0x9df75917ac9747b4a70fa033e4b0182d85b62857,\"Vigor Stone\",DFKVGRST,0")

if not ("0x1f57eb682377f5ad6276b9315412920bdf9530f6" in dups):
    print("0x1f57eb682377f5ad6276b9315412920bdf9530f6,\"Lesser Fortitude Stone\",DFKLFRTIST,0")

if not ("0x17fa96ba9d9c29e4b96d29a7e89a4e7b240e3343" in dups):
    print("0x17fa96ba9d9c29e4b96d29a7e89a4e7b240e3343,\"Fortitude Stone\",DFKFRTIST,0")

if not ("0x4ff7a020ec1100d36d5c81f3d4815f2e9c704b59" in dups):
    print("0x4ff7a020ec1100d36d5c81f3d4815f2e9c704b59,\"Lesser Wit Stone\",DFKLWITST,0")

if not ("0x939ea05c81aac48f7c10bdb08615082b82c80c63" in dups):
    print("0x939ea05c81aac48f7c10bdb08615082b82c80c63,\"Wit Stone\",DFKWITST,0")

if not ("0x762b98b3758d0a5eb95b3e4a1e2914ce0a80d99c" in dups):
    print("0x762b98b3758d0a5eb95b3e4a1e2914ce0a80d99c,\"Lesser Insight Stone\",DFKLINSST,0")

if not ("0x9d71bb9c781fc2ebdd3d6cb709438e3c71200149" in dups):
    print("0x9d71bb9c781fc2ebdd3d6cb709438e3c71200149,\"Insight Stone\",DFKINSST,0")

if not ("0x6d6ea1d2dc1df6eaa2153f212d25cf92d13be628" in dups):
    print("0x6d6ea1d2dc1df6eaa2153f212d25cf92d13be628,\"Lesser Fortune Stone\",DFKLFRTUST,0")

if not ("0x5da2effe9857dcecb786e13566ff37b92e1e6862" in dups):
    print("0x5da2effe9857dcecb786e13566ff37b92e1e6862,\"Fortune Stone\",DFKFRTUST,0")

if not ("0x8f655142104478724bbc72664042ea09ebbf7b38" in dups):
    print("0x8f655142104478724bbc72664042ea09ebbf7b38,\"Moksha Rune\",DFKMOKSHA,0")

if not ("0x45b53e55b5c0a10fdd4fe2079a562d5702f3a033" in dups):
    print("0x45b53e55b5c0a10fdd4fe2079a562d5702f3a033,\"Chaos Crystal\",DFKCHSCR,0")

if not ("0xa509c34306adf6168268a213cc47d336630bf101" in dups):
    print("0xa509c34306adf6168268a213cc47d336630bf101,\"Lesser Chaos Crystal\",DFKLCHSCR,0")

if not ("0x3633f956410163a98d58d2d928b38c64a488654e" in dups):
    print("0x3633f956410163a98d58d2d928b38c64a488654e,\"Lesser Chaos Stone\",DFKLCHSST,0")
