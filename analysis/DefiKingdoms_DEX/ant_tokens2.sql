{{ config(materialized='table', unique_key="CONCAT_WS('-', token_address, token_name)", tags=['playground', 'ant_labels', 'ant_tokens2']) }}
      select '0x5a24e33c1f3ac55b96f818d40d0ad97f71b42658' as token_address, 'TEST Reverse Token' as token_name, 'TESTRVRS' as token_symbol, 18 as decimals
union select '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a' as token_address, 'Wrapped ONE' as token_name, 'WONE' as token_symbol, 18 as decimals
union select '0xf94dffa0d6dbbf20a663907d798ed92565456c33' as token_address, 'Testicles' as token_name, 'TEST' as token_symbol, 18 as decimals
union select '0x59b766f8dfca8834010705833dc33b7b2687dc10' as token_address, 'BNB' as token_name, 'bsc1bscBNB' as token_symbol, 18 as decimals
union select '0xe176ebe47d621b984a73036b9da5d834411ef734' as token_address, 'Binance USD' as token_name, 'BUSD' as token_symbol, 18 as decimals
union select '0x05ce07282be640608bb14d5b5aa04a4b57ba9865' as token_address, 'QUARTZ' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0x224e64ec1bdce3870a6a6c777edd450454068fec' as token_address, 'Wrapped UST Token' as token_name, 'UST' as token_symbol, 18 as decimals
union select '0x582617bd8ca80d22d4432e63fda52d74dcdcee4c' as token_address, 'Cardano Token' as token_name, 'bscADA' as token_symbol, 18 as decimals
union select '0x218532a12a389a4a92fc0c5fb22901d1c19198aa' as token_address, 'ChainLink Token' as token_name, 'LINK' as token_symbol, 18 as decimals
union select '0x72cb10c6bfa5624dd07ef608027e366bd690048f' as token_address, 'Jewels' as token_name, 'JEWEL' as token_symbol, 18 as decimals
union select '0x5f123df9d281ad9b071d616ed8624470f58fcf39' as token_address, 'Shvas Rune' as token_name, 'DFKSRUNE' as token_symbol, 18 as decimals
union select '0x6b10ad6e3b99090de20bf9f95f960addc35ef3e2' as token_address, 'Rockroot' as token_name, 'DFKRCKRT' as token_symbol, 0 as decimals
union select '0x6e85399c21a62d9dc555c2c9b46c4854dd2416c5' as token_address, 'Good Times Coin' as token_name, 'GTC' as token_symbol, 18 as decimals
union select '0xb55106308974cebe299a0f0505435c47b404b9a6' as token_address, 'Eden' as token_name, 'EDEN' as token_symbol, 18 as decimals
union select '0xf4d43c2d6bfadbed33e6ce28b40d1c2995f07c4c' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x3a4edcf3312f44ef027acfd8c21382a5259936e7' as token_address, 'Gold' as token_name, 'DFKGOLD' as token_symbol, 3 as decimals
union select '0x2f0d77eb6d1e3b936ab782e52b541737388e5702' as token_address, 'SmugDoge1' as token_name, 'SMUG1' as token_symbol, 10 as decimals
union select '0x2e16bb971a4608b8e3205bbecd331b71d83abec8' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x139c70f74613e229b1aab2c39df8f73d54df5c80' as token_address, 'FarmersOnly Token' as token_name, 'FOX' as token_symbol, 18 as decimals
union select '0x7bf379fcb16b4a6f648371cd72d9d443ef24168f' as token_address, 'Amethyst' as token_name, 'AME' as token_symbol, 18 as decimals
union select '0x9427a2a738affbc5880f0646b5251069c022e525' as token_address, 'Global Transaction Payment Solution' as token_name, 'GTPS' as token_symbol, 18 as decimals
union select '0x66f5bfd910cd83d3766c4b39d13730c911b2d286' as token_address, 'Shvas rune' as token_name, 'DFKSHVAS' as token_symbol, 0 as decimals
union select '0xa9ce83507d872c5e1273e745abcfda849daa654f' as token_address, 'xJewels' as token_name, 'xJEWEL' as token_symbol, 18 as decimals
union select '0xb12c13e66ade1f72f71834f2fc5082db8c091358' as token_address, 'Avalanche' as token_name, 'AVAX' as token_symbol, 18 as decimals
union select '0x40596735baf0bf101f0e5f4ac1168f1ceba7efa3' as token_address, 'Baby Harmony' as token_name, 'BH' as token_symbol, 18 as decimals
union select '0xb8e0497018c991e86311b64efd9d57b06aedbbae' as token_address, 'DaVinci Token' as token_name, 'VINCI' as token_symbol, 18 as decimals
union select '0x56ba644ae496fb04dffa8679fd6c65ed7de1170e' as token_address, 'DefiKingDomCapital' as token_name, 'DFKCap' as token_symbol, 9 as decimals
union select '0x4f255fda21c2ba823d395d292f763892e354c95c' as token_address, 'Bsnappy' as token_name, 'Bsnappy' as token_symbol, 18 as decimals
union select '0xd009b07b4a65cc769379875edc279961d710362d' as token_address, 'Rain Token' as token_name, 'RAIN' as token_symbol, 18 as decimals
union select '0x1d6300b1d1a1e17112f9a8325ed733b7995bfb2c' as token_address, 'POPCATONE' as token_name, 'POPCAT' as token_symbol, 9 as decimals
union select '0x0159ed2e06ddcd46a25e74eb8e159ce666b28687' as token_address, 'FarmersOnly Token2' as token_name, 'FOX' as token_symbol, 18 as decimals
union select '0x70831ee5f8a0434bd2ddb1e45ed24cbca8b41fec' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x3095c7557bcb296ccc6e363de01b760ba031f2d9' as token_address, 'Wrapped BTC' as token_name, '1WBTC' as token_symbol, 8 as decimals
union select '0x1971b39937cda498e8085dc0da6e59f99bb68176' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xe4cfee5bf05cef3418da74cfb89727d8e4fee9fa' as token_address, 'Ironscale' as token_name, 'DFKIRONSCALE' as token_symbol, 0 as decimals
union select '0x094243dfabfbb3e6f71814618ace53f07362a84c' as token_address, 'Redleaf' as token_name, 'DFKRDLF' as token_symbol, 0 as decimals
union select '0x698027fee7e35691d17881abdd69d625b0b63f04' as token_address, 'Rock$tar' as token_name, 'Rock' as token_symbol, 18 as decimals
union select '0xc2b4e81a4b68a979211b80646f4511fe907465aa' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x4d555a04fa5def837ec219e6fb91f76c04743e68' as token_address, 'Toucan' as token_name, 'TCO2' as token_symbol, 9 as decimals
union select '0x9b68bf4bf89c115c721105eaf6bd5164afcc51e4' as token_address, 'Freyala' as token_name, 'XYA' as token_symbol, 18 as decimals
union select '0x731e39329eeef36abc258002f932e19706555fc3' as token_address, 'Tosa Inu' as token_name, 'TOSA' as token_symbol, 18 as decimals
union select '0xcfa091b154025ab7e5beacc75c66235d1466b3b2' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x3d86f15b545f8be470513ce1addde93582ffbd36' as token_address, 'Novi Protocol' as token_name, 'NOVI' as token_symbol, 18 as decimals
union select '0x09c1b036ad110c0161dba7d920d76049a121120e' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xd41605a6ac77b5878cf7af849ef6663feaed1cd0' as token_address, 'Tamam Finance' as token_name, 'Tmm' as token_symbol, 18 as decimals
union select '0x0e4676368c925faaee37f8ddfbaf13c8311a632e' as token_address, 'Shitzu' as token_name, 'SHIT' as token_symbol, 18 as decimals
union select '0x3c2b8be99c50593081eaa2a724f0b8285f5aba8f' as token_address, 'Tether USD' as token_name, '1USDT' as token_symbol, 6 as decimals
union select '0x60e0d939d4b0c71918088278bcf600470a6c8f26' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0xd74433b187cf0ba998ad9be3486b929c76815215' as token_address, 'Artemis' as token_name, 'MIS' as token_symbol, 18 as decimals
union select '0xc9cf57af196291db545c3696567c65ec8dd76351' as token_address, 'GrumpyCat' as token_name, 'Grumps' as token_symbol, 9 as decimals
union select '0xbd4e27c26a9924abe7c19a365fbc65825d2bf103' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0x985458e523db3d53125813ed68c274899e9dfab4' as token_address, 'USD Coin' as token_name, '1USDC' as token_symbol, 6 as decimals
union select '0xb80a07e13240c31ec6dc0b5d72af79d461da3a70' as token_address, 'Sailfish' as token_name, 'DFKSAILFISH' as token_symbol, 0 as decimals
union select '0x943f5ee79c07370d3b36cc1a2f676796b68c2749' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x0ab43550a6915f9f67d0c454c2e90385e6497eaa' as token_address, 'BUSD Token' as token_name, 'bscBUSD' as token_symbol, 18 as decimals
union select '0xcf323aad9e522b93f11c352caa519ad0e14eb40f' as token_address, 'Aave Token' as token_name, '1AAVE' as token_symbol, 18 as decimals
union select '0x57df5db5aacf3e2ac88a25948ce55e1f3e3f94c2' as token_address, 'Freyas Branch' as token_name, 'DFKBRANCH' as token_symbol, 18 as decimals
union select '0xeb579ddcd49a7beb3f205c9ff6006bb6390f138f' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x0d0b0f01d7fe83bd34326459e052ff74d4245daf' as token_address, 'LAO' as token_name, 'LAO' as token_symbol, 18 as decimals
union select '0x1cb71fdd770131cbaedfa179553dd3a1ce12f66b' as token_address, 'TSD Stablecoin' as token_name, 'TSD' as token_symbol, 18 as decimals
union select '0xbaf7c8149d586055ed02c286367a41e0ada96b7c' as token_address, 'unknown' as token_name, 'unknown' as token_symbol, 8 as decimals
union select '0x00360781af99c7e4dca2ec757e1350a8d5c5a1bd' as token_address, 'LemonDao Token' as token_name, 'LDT' as token_symbol, 18 as decimals
union select '0xfe1b516a7297eb03229a8b5afad80703911e81cb' as token_address, 'Royale' as token_name, 'ROY' as token_symbol, 18 as decimals
union select '0xed0b4b0f0e2c17646682fc98ace09feb99af3ade' as token_address, 'Reverse Token' as token_name, 'RVRS' as token_symbol, 18 as decimals
union select '0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04' as token_address, 'Gaias Tears' as token_name, 'DFKTEARS' as token_symbol, 0 as decimals
union select '0x109ef7f35ce2eb4b90b865f0ed3c90910c0a1770' as token_address, 'GamingZone' as token_name, 'GamingZone' as token_symbol, 18 as decimals
union select '0x68ea4640c5ce6cc0c9a1f17b7b882cb1cbeaccd7' as token_address, 'Darkweed' as token_name, 'DFKDRKWD' as token_symbol, 0 as decimals
union select '0xa71ebb88d300d4ab9fd16e8c587a2799b0f0e71f' as token_address, 'Warm Home' as token_name, 'HOME' as token_symbol, 18 as decimals
union select '0x691f37653f2fbed9063febb1a7f54bc5c40bed8c' as token_address, 'MochiSwap Token' as token_name, 'hMOCHI' as token_symbol, 18 as decimals
union select '0xcb35e4945c7f463c5ccbe3bf9f0389ab9321248f' as token_address, 'OneMoon' as token_name, 'ONEMOON' as token_symbol, 9 as decimals
union select '0x28cb748381f41b3de3a5dc70323f78bfc6fdadef' as token_address, 'BabyFarm Token' as token_name, 'BFARM' as token_symbol, 18 as decimals
union select '0x0ad870c482aa6f0583db6951bb50a652985fd17b' as token_address, 'Bsnappy' as token_name, 'Bsnappy' as token_symbol, 18 as decimals
union select '0x6bac77af0cedd50356c90302993b67fea677570d' as token_address, 'ChadFinance Token' as token_name, 'CHAD' as token_symbol, 18 as decimals
union select '0xaecd10062aba8fff1ab300990ee4679ec668c099' as token_address, 'PartyHat' as token_name, 'PHAT' as token_symbol, 18 as decimals
union select '0xe6881d26bf7c8a6d8267d7a9bae4c439a459994f' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x6e1bc01cc52d165b357c42042cf608159a2b81c1' as token_address, 'Ambertaffy' as token_name, 'DFKAMBRTFY' as token_symbol, 0 as decimals
union select '0x97f9b850d4eb7146363c4feccdd02c0196ec205f' as token_address, 'SpookyCats' as token_name, 'SPOOKY' as token_symbol, 9 as decimals
union select '0xd012305abbdcdb41d83518c334564379e4c2d92d' as token_address, 'Reverse' as token_name, 'RVRS' as token_symbol, 18 as decimals
union select '0x39ab439897380ed10558666c4377facb0322ad48' as token_address, 'Fantom Token' as token_name, '1FTM' as token_symbol, 18 as decimals
union select '0x40d2f81bd135b5282cb2aa18f19cf7098079d012' as token_address, 'IKURA' as token_name, 'IKURA' as token_symbol, 9 as decimals
union select '0xea589e93ff18b1a1f1e9bac7ef3e86ab62addc79' as token_address, 'Viper' as token_name, 'VIPER' as token_symbol, 18 as decimals
union select '0xd7c79a7adc49e1b3033e7615a7d740a7a5b82fd4' as token_address, 'QUARTZ' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0x79a8f48482c4738b4df3848b022c8e7e228b9b9e' as token_address, 'Testaja' as token_name, 'TST' as token_symbol, 18 as decimals
union select '0x5388e2a47a868029baa30d22ef55bab0de6ea305' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xce7404a0aa0ab60ee707ff29facad55f450fcf16' as token_address, 'BACA' as token_name, 'BACA' as token_symbol, 18 as decimals
union select '0x601e607f98219ea557922f86d9963439b71e1742' as token_address, 'Lost' as token_name, 'XXXLOST' as token_symbol, 10 as decimals
union select '0x2789f04d22a845dc854145d3c289240517f2bcf0' as token_address, 'Health' as token_name, 'DFKHLTHPTN' as token_symbol, 0 as decimals
union select '0x82623cfb61c20235e9bd16fe3e07e5109c80c32d' as token_address, 'Taliban' as token_name, 'TLB' as token_symbol, 18 as decimals
union select '0x529b3045522bee17b2ebfe974b358e275665d5f3' as token_address, 'DENGAKU' as token_name, 'bscDENGAKU' as token_symbol, 18 as decimals
union select '0x995a78482d1c74a09858b7940455ac28a632ec54' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x7531905c4c80b602cff46badc1671fbad496f043' as token_address, 'McONE Coin' as token_name, 'MCONE' as token_symbol, 9 as decimals
union select '0x550d9923693998a6fe20801abe3f1a78e0d75089' as token_address, 'Immortl' as token_name, 'IMRTL' as token_symbol, 18 as decimals
union select '0x4cec7eed8a4dcfd5c9f4ae5bc97f0772048b09f2' as token_address, 'LMAO' as token_name, 'LMAO' as token_symbol, 18 as decimals
union select '0x2c585fc1c5276dca2c9330a018785faae3f576b9' as token_address, 'Grey Egg' as token_name, 'DFKGREGG' as token_symbol, 0 as decimals
union select '0xcdffe898e687e941b124dfb7d24983266492ef1d' as token_address, 'Swift-Thistle' as token_name, 'DFKSWFTHSL' as token_symbol, 0 as decimals
union select '0x26de0a4b61cbd1b32f9caff8510118accf8b50cc' as token_address, 'Wrapped sCHEEZ' as token_name, 'wsCHEEZ' as token_symbol, 18 as decimals
union select '0xc5891912718ccffcc9732d1942ccd98d5934c2e1' as token_address, 'Redgill' as token_name, 'DFKREDGILL' as token_symbol, 0 as decimals
union select '0x7e503b282fcbe3f2edc03642dccc425d238c334f' as token_address, 'Minion' as token_name, 'Mini' as token_symbol, 18 as decimals
union select '0x17fdedda058d43ff1615cdb72a40ce8704c2479a' as token_address, 'SuperBid' as token_name, '1SUPERBID' as token_symbol, 18 as decimals
union select '0x58eafe0660601a2fc542a81cb4adf1edb2d45d39' as token_address, 'ElonShib' as token_name, 'ESHIB' as token_symbol, 18 as decimals
union select '0xc2852a5f9439b5494bbe5f023d5bf02ddbc8a040' as token_address, 'HarmonySnake' as token_name, 'HSNAKE' as token_symbol, 18 as decimals
union select '0x43bd877d4addac16ff0a7c2285ff32be6a011f86' as token_address, 'TEST' as token_name, 'TEST' as token_symbol, 18 as decimals
union select '0xabaed82fe5380db3f946cc9b8c124eb30bbda8a1' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0xfbabda1b56cba6cdd63eb7204d5d403d9abd2dcd' as token_address, 'BIGPISS' as token_name, 'BIGPISS' as token_symbol, 18 as decimals
union select '0x600541ad6ce0a8b5dae68f086d46361534d20e80' as token_address, 'Goldvein' as token_name, 'DFKGLDVN' as token_symbol, 0 as decimals
union select '0xbb948620fa9cd554ef9a331b13edea9b181f9d45' as token_address, 'Wrapped sWAGMI' as token_name, 'wsWAGMI' as token_symbol, 18 as decimals
union select '0xd4f0032abcadeefe74eafa898f9d94b099a14f73' as token_address, 'unknown' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x3e018675c0ef63eb361b9ef4bfea3a3294c74c7b' as token_address, 'Kuro Shiba' as token_name, 'KURO' as token_symbol, 9 as decimals
union select '0x2259597c30f2053b1d68630621871c3057f86bb3' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x985afaaa0c6f10a5ab969d29e59acaa16ad2b79a' as token_address, 'quartz.defi' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0xc30a7f9c216b945ff8acfb389e955a637eb0f478' as token_address, 'Elephant' as token_name, 'ELEPHANT' as token_symbol, 18 as decimals
union select '0x19b9f05cde7a61ab7aae5b0ed91aa62ff51cf881' as token_address, 'Spiderfruit' as token_name, 'DFKSPIDRFRT' as token_symbol, 0 as decimals
union select '0x1a42e415cc9ea3b7e86cc5f9720fa823ebe1e3a4' as token_address, 'Heroes' as token_name, 'HE' as token_symbol, 18 as decimals
union select '0x6008c8769bfacd92251ba838382e7e5637c7e74d' as token_address, 'Cosmic Coin' as token_name, 'COSMIC' as token_symbol, 9 as decimals
union select '0x984b969a8e82f5ce1121ceb03f96ff5bb3f71fee' as token_address, 'Fuzz Finance' as token_name, 'FUZZ' as token_symbol, 18 as decimals
union select '0xb1f6e61e1e113625593a22fa6aa94f8052bc39e0' as token_address, 'BNB' as token_name, 'bscBNB' as token_symbol, 18 as decimals
union select '0x043f9bd9bb17dfc90de3d416422695dd8fa44486' as token_address, 'Ragweed' as token_name, 'DFKRGWD' as token_symbol, 0 as decimals
union select '0x6983d1e6def3690c4d616b13597a09e6193ea013' as token_address, 'ETH' as token_name, '1ETH' as token_symbol, 18 as decimals
union select '0x3bcda06e3793027f9a517980ea4651ff81358ac8' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0xf3634a52f5fb74fd7475454e61ee291a1edf6f2a' as token_address, 'tsj1' as token_name, 'tsj1' as token_symbol, 9 as decimals
union select '0x3c3e7defd0287d5a05ced2d8c5b05fcca0fbacbf' as token_address, 'MetaDOGE' as token_name, 'MetaDOGE' as token_symbol, 18 as decimals
union select '0xd6d5936f9323c6fd8c578d10e1a6a9c63a308d85' as token_address, 'VIP Steak' as token_name, 'VIP' as token_symbol, 18 as decimals
union select '0xb211780d2cb2180247da7c1c7984923c2a60f372' as token_address, 'Dusya' as token_name, 'DSU' as token_symbol, 18 as decimals
union select '0xcf1709ad76a79d5a60210f23e81ce2460542a836' as token_address, 'Tranquil' as token_name, 'TRANQ' as token_symbol, 18 as decimals
union select '0x7404f829a121dd210dd8f41504367806191507c9' as token_address, 'WolfMetar' as token_name, '🐺 WOME 🐺' as token_symbol, 18 as decimals
union select '0x88091739b3aeb58ebd95b0f1ac41fbf052bc1008' as token_address, 'ShibaOne' as token_name, 'OSHIB' as token_symbol, 18 as decimals
union select '0xf91f0ad3a5fec865bc8b1b7ecae3803880b66efb' as token_address, 'Jewel Shard' as token_name, 'JS' as token_symbol, 18 as decimals
union select '0x9315957edbda2bfa05c9b32f81eb4ad194295c75' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0x57eb4f6f2e498df12b2d7ac8a2bc265951378c8c' as token_address, 'shib' as token_name, 'shib' as token_symbol, 17 as decimals
union select '0x5725a4cbf2d40fe893e4ef9ccf52b5e47c2c72b6' as token_address, 'Navada Coin' as token_name, 'Navada' as token_symbol, 18 as decimals
union select '0x881e949183f067a1649ebbaea15de40db67d00e7' as token_address, 'JERA UNIVERSE' as token_name, 'JRU' as token_symbol, 9 as decimals
union select '0x8d9e5ace618f032dab74d51ce3b1cfac71ec1da0' as token_address, 'Affinityfinance' as token_name, 'AFNTY' as token_symbol, 9 as decimals
union select '0xfdb89db8beaecce5ce3b47275be0b093536e09a1' as token_address, 'The Three Kingdoms' as token_name, 'TTK' as token_symbol, 18 as decimals
union select '0x7e530f0cc102ba74ceba020bc68281646e1468bf' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x5d1cd3220f62b0550c422d7928f72531c6a6a851' as token_address, 'Haywood' as token_name, 'WOOD' as token_symbol, 18 as decimals
union select '0xbcf24ddcef450915279c5e72e88ca8ee5db7615d' as token_address, 'NAKATAKE' as token_name, 'NKTK' as token_symbol, 18 as decimals
union select '0x79151ee249ab4ad701f1b45777094e97f99ed73b' as token_address, 'babymoon' as token_name, 'babymoon' as token_symbol, 9 as decimals
union select '0x9467a0958c36b0a92b0f9683e65e3223e7428df9' as token_address, 'Amethyst' as token_name, 'AME' as token_symbol, 18 as decimals
union select '0xef977d2f931c1978db5f6747666fa1eacb0d0339' as token_address, 'Dai Stablecoin' as token_name, '1DAI' as token_symbol, 18 as decimals
union select '0x6523688efd8212b83bc30a4e2af98389a9014ed5' as token_address, 'Tranquility City' as token_name, 'LUMEN' as token_symbol, 18 as decimals
union select '0x5e1368b87c8bdf9807290627cdb2aef065318496' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x6261d9904acc8cce43012d7fa5c96603d97a099f' as token_address, 'SpookyPengu' as token_name, 'SPOOKY' as token_symbol, 9 as decimals
union select '0xb4aa8c8e555b3a2f1bfd04234ff803c011760e59' as token_address, 'Locked Tranquil' as token_name, 'xTRANQ' as token_symbol, 18 as decimals
union select '0xac5c49ff7e813de1947dc74bbb1720c353079ac9' as token_address, 'Bluestem' as token_name, 'DFKBLUESTEM' as token_symbol, 0 as decimals
union select '0x7db59d89c79f400f24990f26f66b4b5677bea18e' as token_address, 'SAITAMA' as token_name, 'SAITAMA' as token_symbol, 18 as decimals
union select '0xb688962d3b8d8caa970522babbc057173b56f331' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x0d625029e21540abdfafa3bfc6fd44fb4e0a66d0' as token_address, 'ColonyToken' as token_name, 'CLNY' as token_symbol, 18 as decimals
union select '0x58f1b044d8308812881a1433d9bbeff99975e70c' as token_address, '1INCH Token' as token_name, '11INCH' as token_symbol, 18 as decimals
union select '0x22d62b19b7039333ad773b7185bb61294f3adc19' as token_address, 'Staked One' as token_name, 'stONE' as token_symbol, 18 as decimals
union select '0x7d8da7e25966d9c73c54b24ebcc09c5cb50f2ae4' as token_address, 'CESS' as token_name, 'SESS' as token_symbol, 18 as decimals
union select '0x1ce753cd86c1881411c281bfab533d54086d9377' as token_address, 'BSNAPPY' as token_name, 'bsnappy' as token_symbol, 18 as decimals
union select '0x1383b4e5f5ce72656144a26f2710c2bd3a2efd9a' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x07189ba29febdf88e9c03c8cce976f6b66253e1f' as token_address, 'BabyPiggy' as token_name, 'BPIGGY' as token_symbol, 18 as decimals
union select '0x0ac99600995ef2c9cdaf3ca7a30eff67e8d9661d' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x5ac88d80f6a01e7af4e55faadd04bfc2ea754987' as token_address, 'BetterOne1' as token_name, 'B1' as token_symbol, 10 as decimals
union select '0xcda2fdeee5c382e401c04dc929e53ababf6c8109' as token_address, 'Eight' as token_name, 'EIGHT' as token_symbol, 9 as decimals
union select '0xbec775cb42abfa4288de81f387a9b1a3c4bc552a' as token_address, 'SushiToken' as token_name, '1SUSHI' as token_symbol, 18 as decimals
union select '0x411bf1ac21faa6018f543631570066e1433eb036' as token_address, 'CatDogOne' as token_name, 'CDOG' as token_symbol, 18 as decimals
union select '0x6546d3fc7cde8c2956355b3ddfd80e7ce0116117' as token_address, 'Amethyst' as token_name, 'AME' as token_symbol, 18 as decimals
union select '0x9ad4f6e79386d21fd0c262a323813175ac14bdb0' as token_address, 'Jewel Shiba' as token_name, 'JEWELSHIB' as token_symbol, 18 as decimals
union select '0x470c5c081a6db3cc84364d2741e66b5f351081ee' as token_address, 'spready' as token_name, 'spy' as token_symbol, 18 as decimals
union select '0xb9b5c4e428ab8b0d37d9b6ff742dca7696b9367c' as token_address, 'Boob Coin' as token_name, 'BOOB' as token_symbol, 18 as decimals
union select '0x55caa3f618372267a0de23fd78354223c44515a2' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x50c3ef240da45faeffa9f27d818143c5f97e726c' as token_address, 'DomiOnline Meta' as token_name, 'mDomi' as token_symbol, 18 as decimals
union select '0xfbdd194376de19a88118e84e279b977f165d01b8' as token_address, 'Wrapped Matic' as token_name, 'WMATIC' as token_symbol, 18 as decimals
union select '0xd647090c1cdcdbb72de411b1ba16f03d4a7bba02' as token_address, 'Fantom Token' as token_name, 'rFTM' as token_symbol, 18 as decimals
union select '0x888495d668f3702f992bbe1f069230aa73cd5307' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x662cc3bdfa100eebe60ce4d450ec9308b57604ff' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x8bc77afa4097b7357f917fa7dd117e697e458614' as token_address, 'ElonDoge' as token_name, 'ElonDoge🐕' as token_symbol, 18 as decimals
union select '0xf5e7aaa02c616be2a28c8d6db7924b17fce88dac' as token_address, 'HIM' as token_name, 'HE' as token_symbol, 18 as decimals
union select '0xf02373d73ed1a18cfccc1dea1ea73cc8efa54132' as token_address, 'BSHARE' as token_name, 'BSHARE' as token_symbol, 18 as decimals
union select '0x95ce547d730519a90def30d647f37d9e5359b6ae' as token_address, 'Wrapped LUNA Token' as token_name, 'LUNA' as token_symbol, 18 as decimals
union select '0x53ba62ddd5a9a6b6d97c7a496d7832d13a9218c4' as token_address, 'Avalanche Token' as token_name, 'rAVAX' as token_symbol, 18 as decimals
union select '0xf69ff02a6c6b9c95ed36dde1bc0e22a4b53e8bce' as token_address, 'ShibaOne' as token_name, 'ShibaOne' as token_symbol, 18 as decimals
union select '0xdc2c698af26ff935cd1c50eef3a4a933c62af18d' as token_address, 'Full Mana' as token_name, 'DFKFMNPTN' as token_symbol, 0 as decimals
union select '0x78aed65a2cc40c7d8b0df1554da60b38ad351432' as token_address, 'Bloater' as token_name, 'DFKBLOATER' as token_symbol, 0 as decimals
union select '0x4c1d614d21e354b1c407dfb8b171adc72f0db127' as token_address, 'ReBOA' as token_name, '$RBOA' as token_symbol, 9 as decimals
union select '0x2b24bb17c9bb25668ea01caabd43bf10eaa332eb' as token_address, 'Baby Piggy' as token_name, 'xB Piggy' as token_symbol, 18 as decimals
union select '0x7ca9c1d0bb11f1b7c31ee5538d7a75aaf2d8e2fc' as token_address, 'CryptoPigs Token' as token_name, 'COINKX' as token_symbol, 18 as decimals
union select '0x372caf681353758f985597a35266f7b330a2a44d' as token_address, 'ShimmerSkin' as token_name, 'DFKSHIMMERSKIN' as token_symbol, 0 as decimals
union select '0x4af9d99aa232ef73b65cbd0a8e77be102029852e' as token_address, 'bomb.money' as token_name, 'BOMB' as token_symbol, 18 as decimals
union select '0x95d02c1dc58f05a015275eb49e107137d9ee81dc' as token_address, 'Grey Egg' as token_name, 'DFKGREGG' as token_symbol, 0 as decimals
union select '0x4b3c0bcea4dd4e8849eb00903efa1cdb0697e849' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x79aa5b36bdfca067c7201a32b8c716a3210f16ca' as token_address, 'SANTALONMUSK' as token_name, 'SMUSK' as token_symbol, 9 as decimals
union select '0x9218e4be8138203e8fa231820d302bbe0e51b41c' as token_address, 'CatTeeth' as token_name, 'CT' as token_symbol, 18 as decimals
union select '0x301259f392b551ca8c592c9f676fcd2f9a0a84c5' as token_address, 'Matic Token' as token_name, '1MATIC' as token_symbol, 18 as decimals
union select '0xeeafd7ac4380a5ef963beb84158be5e9ffe76e08' as token_address, 'CryptoPigs' as token_name, 'COINKX' as token_symbol, 18 as decimals
union select '0xcdede8c590d6e3c44c55053a9a7f22bb3e3a8767' as token_address, 'Anubi Coin' as token_name, 'ANUBI' as token_symbol, 18 as decimals
union select '0xdc14e703896bc7bccf727645674cd46924271405' as token_address, 'RainDAO' as token_name, 'Rain' as token_symbol, 18 as decimals
union select '0x5b20d82629f1aca785d823759a62664b78cb431e' as token_address, 'Reverse' as token_name, 'Reverse' as token_symbol, 18 as decimals
union select '0xfc73b5a14f1b2e2b618620eaed98e7df8d8d4a39' as token_address, 'ElonDoge' as token_name, 'eDOGE' as token_symbol, 18 as decimals
union select '0x4970417a897cc7ae812b9b8db34bb44833c26739' as token_address, 'Piggybankone' as token_name, 'COINK' as token_symbol, 18 as decimals
union select '0xb82307ff75f0cd2cfc253ba2621851fd9123a818' as token_address, 'Wrapped UST Token' as token_name, 'bscUST' as token_symbol, 18 as decimals
union select '0xda7fe71960cd1c19e1b86d6929efd36058f60a03' as token_address, 'LUMEN' as token_name, 'LUMEN' as token_symbol, 18 as decimals
union select '0x7dacb1e271926ae41ad45e9b785156ebfbd86bb4' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0xf0aedfcd1110ac9a599d801682d8efe40511de4a' as token_address, 'Locked JEWEL' as token_name, 'L-JEWEL' as token_symbol, 18 as decimals
union select '0xee38eb21d928ba43adcbd2efd4550cc764bf8567' as token_address, 'UFO Farm' as token_name, 'UFO' as token_symbol, 18 as decimals
union select '0xc7ea17d5058ad252d4952eccffbe38df0cae0352' as token_address, 'Bsnappy' as token_name, 'Bsnappy' as token_symbol, 18 as decimals
union select '0xdbab1b87cb02cabcec6e1775d408aa09a1bc0f0f' as token_address, 'NyanToken' as token_name, 'unknown' as token_symbol, 18 as decimals
union select '0xf8a4c9b2fc7170ae1530eee388f2592a496c42cd' as token_address, 'Testicles' as token_name, 'TEST' as token_symbol, 18 as decimals
union select '0x0d12729efd601e7a375922b3551f5fc1a5e6ad05' as token_address, 'Baby MIS' as token_name, 'bMIS' as token_symbol, 18 as decimals
union select '0x3f868f4553b8d5a09ee120d6d96936e77fce5fa2' as token_address, 'unknown' as token_name, 'unknown' as token_symbol, 0 as decimals
union select '0xc778417e063141139fce010982780140aa0cd5ab' as token_address, 'unknown' as token_name, 'unknown' as token_symbol, 0 as decimals
union select '0xfa6c37f8b3706e7631c87ead60ab63929b1d9089' as token_address, 'Red Egg' as token_name, 'DFKREGG' as token_symbol, 18 as decimals
union select '0x8bf4a0888451c6b5412bcad3d9da3dcf5c6ca7be' as token_address, 'Lantern-Eye' as token_name, 'DFKLANTERNEYE' as token_symbol, 0 as decimals
union select '0xf967b352705ba27dbe972231a31e66e28a92d407' as token_address, 'DeadCatAverage' as token_name, 'DCA' as token_symbol, 18 as decimals
union select '0xb44c9173e5ea87fdde13fb9e87e157620323b43d' as token_address, 'MoltenShot Tears' as token_name, 'MSTRS' as token_symbol, 18 as decimals
union select '0x9094b2f225c936e6c9d2c8072b788bc6f73dde7c' as token_address, 'ShitzuHarmony' as token_name, 'SHIT' as token_symbol, 9 as decimals
union select '0x9d6032604b64181b752f943065e025c3e3f24940' as token_address, 'Chonks Tears' as token_name, 'CHONKTEARS' as token_symbol, 18 as decimals
union select '0x3b78766b85aa97dbaa87194ae46c61b87b9f244e' as token_address, '1SHIBA' as token_name, '1SHIBA' as token_symbol, 18 as decimals
union select '0x2493cfdacc0f9c07240b5b1c4be08c62b8eeff69' as token_address, 'Silverfin' as token_name, 'DFKSILVERFIN' as token_symbol, 0 as decimals
union select '0x2b51890f18f1ea2aa65c78aca58fcdc7543037d6' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x17056b13451d25944ca25f01c33e4734b921c311' as token_address, 'Shiba One' as token_name, 'SHIB' as token_symbol, 18 as decimals
union select '0x9a89d0e1b051640c6704dde4df881f73adfef39a' as token_address, 'Tether USD' as token_name, 'bscUSDT' as token_symbol, 18 as decimals
union select '0xc60bf1da33635d0bb862dedfd2e96dc56765926c' as token_address, 'MemeWars' as token_name, 'MEME' as token_symbol, 18 as decimals
union select '0x352cd428efd6f31b5cae636928b7b84149cf369f' as token_address, 'Curve DAO Token' as token_name, '1CRV' as token_symbol, 18 as decimals
union select '0xc5f9a5e107439e8033ad27c46c51a1db191a3e17' as token_address, 'OneMoon' as token_name, 'OneMoon' as token_symbol, 18 as decimals
union select '0x26b39e8d527d9dc9f8fedb00c3ecb00aee6ca472' as token_address, 'Iris' as token_name, 'IRIS' as token_symbol, 18 as decimals
union select '0x728c2feb0b09da60f8c46c7324971c8f33017950' as token_address, 'GrowTrees Finance' as token_name, 'GROW' as token_symbol, 18 as decimals
union select '0x95fcbc19562ef7434fdc6f43d620c26c34c8d5c2' as token_address, 'SmugDoge1' as token_name, 'SMUG1' as token_symbol, 10 as decimals
union select '0xe5dfcd29dfac218c777389e26f1060e0d0fe856b' as token_address, 'Plutus' as token_name, 'PLTS' as token_symbol, 18 as decimals
union select '0x009bb99ee1ebea9712967b8e22ec2697414f802e' as token_address, 'SAITAMA' as token_name, 'STM' as token_symbol, 18 as decimals
union select '0xd500a99ccc0039e3a8c58308e731fab779a60367' as token_address, 'Max supply is literally 1 ' as token_name, 'ONE ' as token_symbol, 9 as decimals
union select '0xe614af4e77f7f2d8e5d3d12fe82d4b718423ff1b' as token_address, 'unknown' as token_name, 'unknown' as token_symbol, 0 as decimals
union select '0x34704c70e9ec9fb9a921da6daad7d3e19f43c734' as token_address, 'DSLA' as token_name, '1DSLA' as token_symbol, 18 as decimals
union select '0x8eb03202275bd598adc23678008ef88655544910' as token_address, 'Radiant' as token_name, 'RADI' as token_symbol, 18 as decimals
union select '0x74ecc7adebab7870f012c0b23489f965d43d6ab0' as token_address, 'PrimeTime' as token_name, 'PTime' as token_symbol, 18 as decimals
union select '0x0359a3e8ed9456a81eaaa8c83415b425a6d004d1' as token_address, 'Bsnappy' as token_name, 'Bsnappy' as token_symbol, 18 as decimals
union select '0x578051af8452da456caaf76a0191ea3aa5bbe307' as token_address, 'PartyHat' as token_name, 'PHAT' as token_symbol, 0 as decimals
union select '0x9a9b18630ff6f0de6fc776f8c5e03bf929b7a90c' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xbd16b0b2eb520b7ff4a4156d367ee359ac19c531' as token_address, 'ARANK' as token_name, 'ARANK' as token_symbol, 18 as decimals
union select '0x3fb0cb373f063dc0b1de333f998b0ca821759b71' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x86c602b59fe35e18f22ed4d7557bf75ec53e9c1f' as token_address, 'Artemis' as token_name, 'MIS' as token_symbol, 18 as decimals
union select '0x01a7e9a6bd623a85a1b1736c9b889bbb8feea867' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0xb98873d2fdabe56cae11566916a8b7bb2a4e59ef' as token_address, 'Soil' as token_name, '1Sl' as token_symbol, 18 as decimals
union select '0x6f84e837a6465b0dc7fde46b29ff5d9d9d7791a8' as token_address, 'TSD Stablecoin' as token_name, 'TSD' as token_symbol, 18 as decimals
union select '0x3ec248ed4b69142a40fb2f2b9d990125a830a598' as token_address, 'CryptoBunny' as token_name, 'NFT' as token_symbol, 18 as decimals
union select '0xfe3e6889ea7a7fe54c45d023a4958b9ee06376cf' as token_address, 'rfJEWEL' as token_name, 'rfJEWEL' as token_symbol, 9 as decimals
union select '0x5db646252a209ec84c25678c478fbff3316f73e6' as token_address, 'Mana' as token_name, 'Mana' as token_symbol, 18 as decimals
union select '0x044246137670a03ca790d7ed20af0c552c88117c' as token_address, 'Arbiter' as token_name, 'ARB' as token_symbol, 18 as decimals
union select '0xc0431ddcc0d213bf27ececa8c2362c0d0208c6dc' as token_address, 'OpenSwap Token' as token_name, 'oSWAP' as token_symbol, 18 as decimals
union select '0x6a60ba0449b276c55d0453752327bb392007aaa6' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x8db4cb67c86440ef4d6abfe7b7c344bb92f9dcc3' as token_address, 'ONE METAVERSE INDEX' as token_name, 'OMI' as token_symbol, 18 as decimals
union select '0x6e9fb6b80d0af0b461f4525e554cd8b999bbdab8' as token_address, 'tstAV' as token_name, 'tstAV' as token_symbol, 9 as decimals
union select '0x684436d3a6b5b230961298f6198a4fdabc229502' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x304ecf4d286bc771a8981b6e5770d5f4ffbea6e0' as token_address, 'One Floki' as token_name, 'Floki🐕' as token_symbol, 18 as decimals
union select '0x38a4dfbcd850a90fa554ee06022d351e89eeee31' as token_address, 'KUMA' as token_name, 'KUMA' as token_symbol, 18 as decimals
union select '0x4e15d4a9bcac94522b7e3c79366c1ed07ffa5948' as token_address, 'Meta Inu' as token_name, 'Meta' as token_symbol, 18 as decimals
union select '0x57617585714aa41fba168a6055df659769300523' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xe02dd81529037ad1a485eba005cb73957afd97a9' as token_address, 'Reverse Protocol' as token_name, 'RVRS' as token_symbol, 18 as decimals
union select '0xa5eb95d5ac30d549bfee5275f7be1e2694c2f794' as token_address, 'Ikura Protocol' as token_name, 'IKURA' as token_symbol, 18 as decimals
union select '0x44a067fabdde66ca20da08c4f66f18d706bcb888' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xb0fb0319d931e89aacd3910c4a487d8a42216ded' as token_address, 'MemeFights' as token_name, 'MF' as token_symbol, 18 as decimals
union select '0x959ba19508827d1ed2333b1b503bd5ab006c710e' as token_address, 'Stamina Potion' as token_name, 'DFKSTMNPTN' as token_symbol, 18 as decimals
union select '0x22423c420d976ce91ab5d91285b14129eb6c3489' as token_address, 'Champ Coin' as token_name, 'CHP' as token_symbol, 18 as decimals
union select '0xd63d68818a56c6a8e8777446d0dda72ed792866c' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xe7bbe0e193fdfe95d2858f5c46d036065f8f735c' as token_address, 'Boss' as token_name, 'BOSS' as token_symbol, 18 as decimals
union select '0xb2f9570c26b293a580223d8c3edd7f94a917e733' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x7b5f4ad43c414a9c85a581b77869e2855a203f12' as token_address, 'SpookyCats' as token_name, 'SPOOKY' as token_symbol, 9 as decimals
union select '0x44afdbe2cb42cc18759159f7e383afb0ca8e57ad' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x24b6179e4062ed9baeace0e6081dbd55b6072380' as token_address, 'FlokiONE' as token_name, 'FLOKI' as token_symbol, 9 as decimals
union select '0x596741acd5f540c1ba7378df2701ec2031108e55' as token_address, 'HAWAII' as token_name, 'HAWAII' as token_symbol, 9 as decimals
union select '0xd6ca29f43ece5e5367b2147655b76310cbeb66c3' as token_address, 'NyanToken' as token_name, 'HNYAN' as token_symbol, 18 as decimals
union select '0x5903720f0132e8bd48530010d9b3192b25f51d8e' as token_address, 'CopyPasta' as token_name, 'PASTA' as token_symbol, 18 as decimals
union select '0x892d81221484f690c0a97d3dd18b9144a3ecdfb7' as token_address, 'Magic' as token_name, 'MAGIC' as token_symbol, 18 as decimals
union select '0x4987c086fdda8a2784f187ad35f398118a43b998' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xd96e15f2b6648304afc71df6eb7768e689fef9df' as token_address, 'War Doge' as token_name, 'WarDoge' as token_symbol, 18 as decimals
union select '0x8327ea6c8c8f208ecd3b7ac6001ceb5189695313' as token_address, 'Green Pet Egg' as token_name, 'DFKGNEGG' as token_symbol, 18 as decimals
union select '0x735abe48e8782948a37c7765ecb76b98cde97b0f' as token_address, 'Fantom' as token_name, 'FTM' as token_symbol, 18 as decimals
union select '0xbda99c8695986b45a0dd3979cc6f3974d9753d30' as token_address, 'unknown' as token_name, 'LOOT' as token_symbol, 0 as decimals
union select '0xcffa951d31cec708bd33272bc2cd7ac5af72a26e' as token_address, 'BabySmug' as token_name, 'BABYSMUG' as token_symbol, 18 as decimals
union select '0x8e32802f6c82bd15b59370f7649571168f5d74c0' as token_address, 'Shiro Shiba' as token_name, 'SHIRO' as token_symbol, 18 as decimals
union select '0x9d1ccb8d33a3f91488c9a06c869871010b246a6c' as token_address, 'DFK CRYSTAL' as token_name, 'CRYSTAL' as token_symbol, 18 as decimals
union select '0x25eac8f49539d52c50b7cb21e0a9e9cfc640fc49' as token_address, 'SHIBA_WOOF' as token_name, 'WOOF' as token_symbol, 16 as decimals
union select '0xf3ee4775be290b992a48dc93def82e162a0e4131' as token_address, 'HarmonicCat' as token_name, 'HCAT' as token_symbol, 9 as decimals
union select '0x1e05c8b69e4128949fcef16811a819ef2f55d33e' as token_address, 'Sonic' as token_name, 'SONIC' as token_symbol, 18 as decimals
union select '0x10010078a54396f62c96df8532dc2b4847d47ed3' as token_address, 'Hundred Finance' as token_name, 'HND' as token_symbol, 18 as decimals
union select '0x83c006d4d36f9c44d06532366098e456269f92b8' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0xfb163e7349fd149d1e4a1052a045d285c1bed98f' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x0e0094b37bae95f6189677b0a03eb0af342a9638' as token_address, 'BABYBOO' as token_name, 'BABYBOO' as token_symbol, 18 as decimals
union select '0x6b53ca1ed597ed7ccd5664ec9e03329992c2ba87' as token_address, 'SushiSwap LP Token' as token_name, 'SLP' as token_symbol, 18 as decimals
union select '0x7ba36d67023e3a7e3ec5416cbc6b0b078d2b53c7' as token_address, 'rfAVAX' as token_name, 'rfAVAX' as token_symbol, 9 as decimals
union select '0xbd11f79bf3e2ba6cf7868420f74e6f6decc580bc' as token_address, 'Bronze Swords' as token_name, 'DFKSWORD' as token_symbol, 18 as decimals
union select '0xf861f79a23f2d38d2fe9db9cef80efe0b04a9d16' as token_address, 'RocketMoon🚀' as token_name, 'RocketMoon🚀' as token_symbol, 18 as decimals
union select '0xad29422c14757a8193ea96ebc8662a5a9636129e' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x277956523f088b73d968b5659256e76e61349a7e' as token_address, 'wBUYBACK' as token_name, 'bscwBBT' as token_symbol, 18 as decimals
union select '0x5925452ac02ba74ddf5584fbe7ac0fd0b50ce1fd' as token_address, 'Silver Swords' as token_name, 'DFKSSWORD' as token_symbol, 18 as decimals
union select '0x777b83c70d604eaa464020e5f0492a05fba2bb86' as token_address, 'HeroFarm' as token_name, 'HeroFarm' as token_symbol, 18 as decimals
union select '0xf720b7910c6b2ff5bd167171ada211e226740bfe' as token_address, 'Wrapped Ether' as token_name, '1WETH' as token_symbol, 18 as decimals
union select '0xf38593388079f7f5130d605e38abf6090d981ec2' as token_address, 'Staked WAGMI' as token_name, 'sWAGMI' as token_symbol, 9 as decimals
union select '0xe90f34d69e8c1077c5cb96f8da729c01abc05b2b' as token_address, 'BetterOne1' as token_name, 'B1' as token_symbol, 10 as decimals
union select '0x5733a6fd81ad74bff90d7ae38ecbdf95897b7b18' as token_address, 'Elon Doge' as token_name, 'ELON' as token_symbol, 18 as decimals
union select '0xbbd83ef0c9d347c85e60f1b5d2c58796dbe1ba0d' as token_address, 'Cheese' as token_name, 'CHEEZ' as token_symbol, 9 as decimals
union select '0x7f110f9aebc4addf035bd1ca8216632c8b82e05f' as token_address, 'Enhancement Stone' as token_name, 'DFKESTONE' as token_symbol, 18 as decimals
union select '0xf3463b4a5903fbacb9ca492aa41e1f53d2e4e95d' as token_address, 'Baby Shiba ' as token_name, 'BabySHIB' as token_symbol, 18 as decimals
union select '0xd901634ae1dfa9df0b8fd87729b8db835acfeba4' as token_address, 'Kishu One' as token_name, 'Kishu One' as token_symbol, 18 as decimals
union select '0xf85cbc2f3439f4084956a5b9e9ecabf75dcccff8' as token_address, 'SCAMCOIN' as token_name, 'SCAM' as token_symbol, 18 as decimals
union select '0x41baee94469444bf202f95a4e8d6edbde78d2311' as token_address, 'PartyHat' as token_name, 'PHAT' as token_symbol, 18 as decimals
union select '0x6a421a60b873e231ecc0932701e569cc4b5404e2' as token_address, 'JewelPrinter' as token_name, 'JEWELp' as token_symbol, 18 as decimals
union select '0xe55e19fb4f2d85af758950957714292dac1e25b2' as token_address, 'Synapse' as token_name, 'SYN' as token_symbol, 18 as decimals
union select '0x3e63c18201f0bbb3801d91894ff72481e15963ed' as token_address, 'OneZoro' as token_name, 'ZORO' as token_symbol, 18 as decimals
union select '0x44ced87b9f1492bf2dcf5c16004832569f7f6cba' as token_address, 'USD Coin' as token_name, 'bscUSDC' as token_symbol, 18 as decimals
union select '0x124b942bcbc316ef4a4183033394097a61777247' as token_address, 'ElonOne' as token_name, 'ElonOne' as token_symbol, 18 as decimals
union select '0xbf590ee32656922d3b7673e06982a8ec8fca0544' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x6c1d726f059f7eb5c394d53575ff85a976b0bbdf' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xba7f9b1b7f90bd3b53a8d0a8a69a21c54b15438b' as token_address, 'Breaktime.rocks' as token_name, 'GOV' as token_symbol, 18 as decimals
union select '0x7c9a834c1ad436f611c0785f10eff23bc77346dd' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x9e8298c6a87423797ed02fd5d3c0e4b25f4421e6' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x051824ee2b9eb6d3c2c4f43315098c030c822470' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xe548fb0af5dc3b91ba41ec28d5004d9192c3cd57' as token_address, 'ShitzuHarmony' as token_name, 'SHIT' as token_symbol, 9 as decimals
union select '0x0cc52311c9a6e97ee42cc487b9d28f07b17d86d1' as token_address, 'Squid One' as token_name, 'SQUID' as token_symbol, 18 as decimals
union select '0x3bde71e6495e94803eeec04addcc1212fe3595fb' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x2b9d4fd80e17bd2b23fc1a201fc815917a55064c' as token_address, 'CHEEZ' as token_name, 'CHEEZ' as token_symbol, 18 as decimals
union select '0x0f3ba759332197b09b892b9405cf64287a2ec0fa' as token_address, 'QUARTZ' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0x1bb6b408b6ad7343dbf0bd7751a9b7000963cf89' as token_address, 'Wrapped LUNA Token' as token_name, '1LUNA' as token_symbol, 18 as decimals
union select '0x95e254da101a8a40e0905403dfe5438852058b5e' as token_address, 'Arbitrum.one' as token_name, 'ABR' as token_symbol, 9 as decimals
union select '0xd62bd801a1cb65532def9908c67b8c00f432c1bb' as token_address, 'LootBlocks Protocol' as token_name, 'LBLOX' as token_symbol, 18 as decimals
union select '0xfda479630f8f515dd70e1b5cf24ba5c2a6a303ec' as token_address, 'BetterOne1' as token_name, 'B3' as token_symbol, 10 as decimals
union select '0x638cd73ddd0e51d1c174c469483507abc8fcc8f6' as token_address, 'ScobyDoo' as token_name, 'DOO' as token_symbol, 18 as decimals
union select '0x637f2490838794c9a07154284c6c288961b839f0' as token_address, 'FC' as token_name, 'FC' as token_symbol, 9 as decimals
union select '0xd3a50c0dce15c12fe64941ffd2b864e887c9b9e1' as token_address, 'HarmonApe' as token_name, 'APE' as token_symbol, 9 as decimals
union select '0x1733038e4076ba9917f603b88230985942b78820' as token_address, 'DBI' as token_name, 'DBI' as token_symbol, 9 as decimals
union select '0x232804a29173d6e2e1068f28a9c754b2229c5203' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xfa57d208480c44379d27a86904aa9177122c8c75' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x4ad61ab2c06a67a3ca0b579f00b2f8e103357bde' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x5c234f74e4fe8dcb3794dac0006b3b85c1aa528a' as token_address, 'MoonMissonOne' as token_name, 'MMO' as token_symbol, 9 as decimals
union select '0xafcbe85ddaf079526b4ae235452a95ba05fad712' as token_address, 'quartz.money' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0x6ffc62c16b6f88e0eef4fcf71c84c68e9651df22' as token_address, 'CatMoon' as token_name, 'CatMoon' as token_symbol, 18 as decimals
union select '0x80b90bf5058f4c77eb27c58d17ed5196ffad8ad3' as token_address, 'SpookyCats' as token_name, 'SPOOKY' as token_symbol, 9 as decimals
union select '0x326e409a4148065fc8b95db3762cba5e96ef3ab8' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x087b54f6cd1152aa61486c70f073e17fc64d3909' as token_address, 'BAS' as token_name, 'BAS' as token_symbol, 18 as decimals
union select '0x33db20cb181245e55d39ee0dab575305e26abf9d' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x3ceba57a1aa15a35a4a29a9e067d4ae441de779f' as token_address, 'Babymis' as token_name, 'bMIS' as token_symbol, 18 as decimals
union select '0x3faf707671cff93cc552588f2bdb119fae3bfb70' as token_address, 'Goku' as token_name, 'GOKU' as token_symbol, 18 as decimals
union select '0xc74eaf04777f784a7854e8950daeb27559111b85' as token_address, 'Jewel LP Token' as token_name, 'JEWEL-LP' as token_symbol, 18 as decimals
union select '0x8c961802f6864cdb4916b1b5188a5580b6afc7dc' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0x9e37acd65b7620a387d3a1cfaf187f50c3bb6b19' as token_address, 'TSD Stablecoin' as token_name, 'TSD' as token_symbol, 18 as decimals
union select '0x90ed822a5ca1e206b34c35464136f154183cef5e' as token_address, 'Defi Wars' as token_name, 'Wars' as token_symbol, 18 as decimals
union select '0x130dd09cc743935f7c097e2ca9e77e69a6134404' as token_address, 'SWAGMI' as token_name, 'SWAGMI' as token_symbol, 18 as decimals
union select '0xf085686545ad9b6f2df711898814207bfa20fa8a' as token_address, 'TSD Stablecoin' as token_name, 'TSD' as token_symbol, 18 as decimals
union select '0xc18586b029412e7a8e6f64b269a32c9eeaf174e5' as token_address, 'Baby Heros' as token_name, 'BBHR' as token_symbol, 18 as decimals
union select '0x63cc356046b9d1d0a02c7114651feb17c851af7b' as token_address, 'unknown' as token_name, 'unknown' as token_symbol, 9 as decimals
union select '0x3f56e0c36d275367b8c502090edf38289b3dea0d' as token_address, 'Mai Stablecoin' as token_name, 'MAI' as token_symbol, 18 as decimals
union select '0x107fbfee852fe413ebaa1551015944d72f90767c' as token_address, 'ChadFinance Token' as token_name, 'CHAD' as token_symbol, 18 as decimals
union select '0x3e9d32580b0bf3ae72afcbebc68710d2fd9a18f0' as token_address, 'PancakeSwap Token' as token_name, 'bscCake' as token_symbol, 18 as decimals
union select '0x9f6d97dd4f57b139a9c516a222fc78da751226cf' as token_address, 'Killer Shiba' as token_name, 'KILL' as token_symbol, 18 as decimals
union select '0x0dd740db89b9fda3baadf7396ddad702b6e8d6f5' as token_address, 'MochiSwap Token' as token_name, 'hMOCHI' as token_symbol, 18 as decimals
union select '0xe8a386cde02ce732fcb473a60a5297eb42a21eb2' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xc0214b37fcd01511e6283af5423cf24c96bb9808' as token_address, 'Milkweed' as token_name, 'DFKMILKWEED' as token_symbol, 0 as decimals
union select '0x89d3e7900a58384a4ecca41f82c04355e9766c88' as token_address, 'OneBank' as token_name, 'OBANK' as token_symbol, 18 as decimals
union select '0x5d9ab5522c64e1f6ef5e3627eccc093f56167818' as token_address, '(PoS) Wrapped BTC' as token_name, 'WBTC' as token_symbol, 8 as decimals
union select '0x4a917a13101f871b78983f1c99d5a7ab81d0cbcc' as token_address, 'GrumpyCat' as token_name, 'Grumps' as token_symbol, 9 as decimals
union select '0xfdd9f2ef462e464b961354ffe8e98bf282c6490d' as token_address, 'OnelyFans' as token_name, 'Onely' as token_symbol, 10 as decimals
union select '0x42d7d9fb501e7553cdbd03ab3697c29592c832a5' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x2cebbfe67d772329e1e4544390c31e45d6f3eb93' as token_address, 'QUARTZ' as token_name, 'QUARTZ' as token_symbol, 18 as decimals
union select '0x350ee31a52d42703bffea3f1ede73b5e90302235' as token_address, 'DONTBUYIT' as token_name, 'DONT' as token_symbol, 6 as decimals
union select '0x7fd8cc197d2b6b386f02a1afccfd5aa7001ae1dd' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x45db42145a97bcf92dbb978bb65c457c6858eb21' as token_address, 'Meta Kitty' as token_name, 'Kitty' as token_symbol, 18 as decimals
union select '0x803d75348ce2c2143fe6b32469859a9d46ec7a44' as token_address, 'Reverse Protocol' as token_name, 'RVRS' as token_symbol, 18 as decimals
union select '0xc7c7c19153492a6bdb20ad4d62c031f0c33362e0' as token_address, 'BabyPepeTruge' as token_name, 'BPT' as token_symbol, 9 as decimals
union select '0x0dc78c79b4eb080ead5c1d16559225a46b580694' as token_address, 'Euphoria' as token_name, 'WAGMI' as token_symbol, 9 as decimals
union select '0x25dcee96fcd63ad88b812cce02b3fcf7d1504f2d' as token_address, 'Troll' as token_name, 'TROLL' as token_symbol, 0 as decimals
union select '0x40f0b1b2a249347532c76b3b34d89b0e15221b40' as token_address, 'Boner Coin' as token_name, 'BONE' as token_symbol, 18 as decimals
union select '0x6e7be5b9b4c9953434cd83950d61408f1ccc3bee' as token_address, 'Matic Token' as token_name, 'bscMATIC' as token_symbol, 18 as decimals
union select '0xbcf532871415bc6e3d147d777c6ad3e68e50cd92' as token_address, 'PartyHat' as token_name, 'PHAT' as token_symbol, 18 as decimals
union select '0x76615dbfe12a05e6eeb537ea87b774bd8a61fcea' as token_address, 'SpookyCats' as token_name, 'SPOOK' as token_symbol, 9 as decimals
union select '0x600817161da8a85be5916a2b0d2a264e7c5252e0' as token_address, 'Anchor' as token_name, 'ANC' as token_symbol, 18 as decimals
union select '0xefa6fb96ec8e094624c21ec1bff18d81a58fa94a' as token_address, 'Stake' as token_name, 'Stake' as token_symbol, 18 as decimals
union select '0x9f3824ab6b76eb4b9ee312a5c73375cf21819f13' as token_address, 'MultiRoleTalentFanToken' as token_name, 'MRTFT' as token_symbol, 18 as decimals
union select '0xaad96d04f00b718b9ed43e39db8e73de61cef8b7' as token_address, 'Orbs' as token_name, '1ORBS' as token_symbol, 18 as decimals
union select '0x698d07ed9f25d683864e20c7dd1cfba70d0e53a2' as token_address, 'JewelPrinter' as token_name, 'JewelP' as token_symbol, 18 as decimals
union select '0x66cf8375fd083e7d103d69378e9af20f1b46dc59' as token_address, 'Harmony Play' as token_name, 'HPLAY' as token_symbol, 18 as decimals
union select '0xe4e5aa9ae668c9335dfce4bafeddce83574673a7' as token_address, 'Bsnappy' as token_name, 'Bsnappy' as token_symbol, 18 as decimals
union select '0x4f5839b38ed4de03c6ab5257b96a8dc8a3e76ff4' as token_address, 'SmugDoge1' as token_name, 'SMUG1' as token_symbol, 10 as decimals
union select '0x14a7b318fed66ffdcc80c1517c172c13852865de' as token_address, 'Axie Infinity Shard' as token_name, '1AXS' as token_symbol, 18 as decimals
union select '0x4c1e2b2bcfb107ab1453e3e42732500a3bc48fd6' as token_address, 'PolyShield' as token_name, 'SHI3LD' as token_symbol, 18 as decimals
union select '0xf04d2605b3644db7a407f033e6ff72f3aa7bd50f' as token_address, 'HarmoNeon' as token_name, 'HNeon' as token_symbol, 18 as decimals
union select '0x1d560021af3cd0babc969db7ddc73763832e35b4' as token_address, 'Lost' as token_name, 'XXXLOST1' as token_symbol, 10 as decimals
union select '0x3a100ddd3b27c7f25891f08ff52e7ec15eecf020' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x0b6ed87b1c646407d49b10d72daa76f8205b2b18' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xfc417a0368263140c59b7aab646d4a270c37d8cb' as token_address, 'Jewel LP Token' as token_name, 'unknown' as token_symbol, 0 as decimals
union select '0x2becf5a3a21a2c3286cbb4b851fc4c8f37b2d0f2' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0x894342c40400f7efd3ffa5fe15ebbc3945437ba3' as token_address, 'SmugDoge1' as token_name, 'SMUG1' as token_symbol, 10 as decimals
union select '0xeda17678e4d5848efc41ef41506fd62bb7f397c8' as token_address, 'Crystal' as token_name, 'CRYSTAL' as token_symbol, 18 as decimals
union select '0xa5445d24e5dbf641f76058cd7a95b1c402eb97b5' as token_address, 'Alien Worlds Trilium' as token_name, 'bscTLM' as token_symbol, 4 as decimals
union select '0xc3dc73f7e9ac7d8e39838ced250d0baa9f3fc45f' as token_address, 'JGOD' as token_name, 'JGOD' as token_symbol, 0 as decimals
union select '0x541353da92016a4fa37699ad7091aa71bbb9e4af' as token_address, 'SANTALONMUSK' as token_name, 'SMUSK' as token_symbol, 9 as decimals
union select '0x8e56ca9d40c97bbe4705305a1ec2c89941292640' as token_address, 'CHONK' as token_name, 'CHK' as token_symbol, 18 as decimals
union select '0x8cf631cdda31ebe5840ed75a471032e695be2e4b' as token_address, 'Testicles' as token_name, 'TEST' as token_symbol, 18 as decimals
union select '0xf37051c958188071bce142f5c2ba4c057d852e83' as token_address, 'Baby Kuma Inu' as token_name, 'BabyKuma' as token_symbol, 18 as decimals
union select '0xda8f7a71e67139dbcd4c42cb6468bf5b8ffe03dd' as token_address, 'Metaverse Token' as token_name, 'META' as token_symbol, 18 as decimals
union select '0xa298c92b10b9b5a43e6680cbf2737fcb8453bfd8' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xa2abc1e9648daa0f61f0921ca071cef39eeced3c' as token_address, 'CHEEZ' as token_name, 'CHEEZ' as token_symbol, 18 as decimals
union select '0x6bc1a427a221af17aa08f47a70aac84c78ec73e1' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x0e46329818cba82ec89448b5f874a60e54c8d103' as token_address, 'Kishu Inu' as token_name, 'Kishu' as token_symbol, 18 as decimals
union select '0x03c2d64ca41d833404bc802ca556e688e2c86dbf' as token_address, 'Wrapped sCHEEZ' as token_name, 'wsCHEEZ' as token_symbol, 18 as decimals
union select '0x562f8057c909610427ada0b18eae06a2f1a3fa51' as token_address, 'ShibaInu' as token_name, 'SHIBI' as token_symbol, 18 as decimals
union select '0xc43dc1860e7ee134224edaaf3f8d1542048366b5' as token_address, 'Aragon' as token_name, 'Aragon' as token_symbol, 18 as decimals
union select '0x20c362b45092d893b6b820e0eca9e19d5e540a34' as token_address, 'Breaktime.rocks' as token_name, 'GOV' as token_symbol, 18 as decimals
union select '0xe6be183d5920479c2a3503ea35474dee21e34594' as token_address, 'CryptoVIR Token' as token_name, 'CVR' as token_symbol, 18 as decimals
union select '0x4507d6b9c8cf150f5890c818546fb31c110d979a' as token_address, 'OneYFI' as token_name, 'OYFI' as token_symbol, 18 as decimals
union select '0x6b6fd3c5d48ce1d33af382a7111dc881c39174a5' as token_address, 'ElonDoge🐕' as token_name, 'ElonDoge🐕' as token_symbol, 18 as decimals
union select '0x9ec06aff00e426e035d58e49fef4ee5e472589e5' as token_address, 'BetterOne1' as token_name, 'B3' as token_symbol, 10 as decimals
union select '0x8dce95045345856a01de84927bd113c3e2097927' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xb184a6cba765ce4ada2e286b1e7b5197b277e1df' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xebceb7a8cb42f4babe43006ee9724fa5f2a260c3' as token_address, 'BABYJEWEL' as token_name, 'BABYJEWEL' as token_symbol, 18 as decimals
union select '0x8e1588805a72d455deef4797568757730611fba8' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x36304804a99350e4764c2fea5bed917ed090e744' as token_address, 'GOfundme' as token_name, 'GOF' as token_symbol, 18 as decimals
union select '0x68683523e7973b666d95bd1dda154597c4578f45' as token_address, 'Persona' as token_name, 'PERS' as token_symbol, 18 as decimals
union select '0x15f2ad4b703b879dfda1cafd78bab9a52ca8a985' as token_address, 'Rocket Shiba' as token_name, 'RockSHIB' as token_symbol, 18 as decimals
union select '0x4f08c10f495d8d16dbd30efdf32285c85df0759f' as token_address, 'BabyEden' as token_name, 'bEDEN' as token_symbol, 18 as decimals
union select '0x19b020001ab0c12ffa93e1fdef90c7c37c8c71ef' as token_address, 'Mana' as token_name, 'DFKMNPTN' as token_symbol, 0 as decimals
union select '0xce892acec607fd80b9ea12d698446ef044e22aa8' as token_address, 'Floki One' as token_name, 'Floki' as token_symbol, 18 as decimals
union select '0xebcb76cd65138c1fb827d4cc8dec7a0cf2fe2069' as token_address, 'QSHARE' as token_name, 'QSHARE' as token_symbol, 18 as decimals
union select '0xc278beec731a0a3f318f5dc69ce9f7c10c7e9303' as token_address, 'WAIFU' as token_name, 'WAIFU' as token_symbol, 18 as decimals
union select '0x87361363a75c9a6303ce813d0b2656c34b68ff52' as token_address, 'Full Health' as token_name, 'DFKFHLTHPTN' as token_symbol, 0 as decimals
union select '0xa4fe0e18506b3d171c7674698991dfaf238621a6' as token_address, 'Weedcommerce' as token_name, 'bscWCM' as token_symbol, 18 as decimals
union select '0x260ce37e5d7dcf3faba91399ad0a0c79bdee6094' as token_address, 'MamaShiba' as token_name, 'MSHIB' as token_symbol, 18 as decimals
union select '0x81472662828f2a1c567b6afb9ee99c3d82fb4932' as token_address, 'BABYTRANQ' as token_name, 'BABYTRANQ' as token_symbol, 18 as decimals
union select '0xa72a7d4d34d8fbf18c64b4224a43f2222c8c28df' as token_address, 'Metaverse' as token_name, 'Metaverse' as token_symbol, 18 as decimals
union select '0x36044859141c117794b00cb296d6b56847ab3281' as token_address, '1SHIB' as token_name, '1SHIB' as token_symbol, 18 as decimals
union select '0x020a5f4bdb2a4c2b95521ff4001a5a087fe1acdb' as token_address, 'BetterOne1' as token_name, 'B2' as token_symbol, 10 as decimals
union select '0x13e95dc2077e23fd0fc80e0b0bdbd7470be00a22' as token_address, 'CESS' as token_name, 'SESS' as token_symbol, 18 as decimals
union select '0x4b1ea7d2b9019d175432960f520489fc09698564' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0xe3f7af01534b1102ecbe075341050690121295b3' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x7b315dc0b7a517013427037a27539833ddba5903' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x7eb2cfb5ed99a552cb1389cdac3d5c20c4fb23e5' as token_address, 'Warena' as token_name, 'Warena' as token_symbol, 18 as decimals
union select '0xa2194737594e1c34dddfe20e2d8a1835b54f4734' as token_address, 'SmugDoge.com' as token_name, 'SMUG' as token_symbol, 9 as decimals
union select '0x0a0314d170033ad63a23ab3311ecb0d8a545a45c' as token_address, 'HIM' as token_name, 'HE' as token_symbol, 18 as decimals
union select '0x9edb3da18be4b03857f3d39f83e5c6aad67bc148' as token_address, 'Golden Egg' as token_name, 'TMP_DFKGOLDEGG' as token_symbol, 0 as decimals
union select '0x6d605303e9ac53c59a3da1ece36c9660c7a71da5' as token_address, 'Green Pet Egg' as token_name, 'TMP_DFKGRNEGG' as token_symbol, 0 as decimals
