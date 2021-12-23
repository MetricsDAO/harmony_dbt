{{ config(materialized='table', unique_key="CONCAT_WS('-', contract_name, contract_address)", tags=['playground', 'ant_labels']) }}

-- https://github.com/DefiKingdoms/contracts
-- https://discord.com/channels/861728723991527464/896870883468136469/896870927382507531
      select 'Serendale_Gaia Tears'                    as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04') as contract_address                                  
union select 'Serendale_Ambertaffy'                    as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x6e1bc01cc52d165b357c42042cf608159a2b81c1') as contract_address                                    
union select 'Serendale_Darkweed'                      as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x68ea4640c5ce6cc0c9a1f17b7b882cb1cbeaccd7') as contract_address                                      
union select 'Serendale_Goldvein'                      as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x600541ad6ce0a8b5dae68f086d46361534d20e80') as contract_address                                      
union select 'Serendale_Ragweed'                       as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x043f9bd9bb17dfc90de3d416422695dd8fa44486') as contract_address                                       
union select 'Serendale_Redleaf'                       as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x094243dfabfbb3e6f71814618ace53f07362a84c') as contract_address                                       
union select 'Serendale_Rockroot'                      as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x6b10ad6e3b99090de20bf9f95f960addc35ef3e2') as contract_address                                      
union select 'Serendale_Swift-Thistle'                 as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0xcdffe898e687e941b124dfb7d24983266492ef1d') as contract_address                                 
union select 'Serendale_Bloater'                       as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x78aed65a2cc40c7d8b0df1554da60b38ad351432') as contract_address                                       
union select 'Serendale_Ironscale'                     as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0xe4cfee5bf05cef3418da74cfb89727d8e4fee9fa') as contract_address                                     
union select 'Serendale_Lanterneye'                    as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x8bf4a0888451c6b5412bcad3d9da3dcf5c6ca7be') as contract_address                                    
union select 'Serendale_Redgill'                       as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0xc5891912718ccffcc9732d1942ccd98d5934c2e1') as contract_address                                       
union select 'Serendale_Sailfish'                      as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0xb80a07e13240c31ec6dc0b5d72af79d461da3a70') as contract_address                                      
union select 'Serendale_Shimmerskin'                   as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x372caf681353758f985597a35266f7b330a2a44d') as contract_address                                   
union select 'Serendale_Silverfin'                     as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x2493cfdacc0f9c07240b5b1c4be08c62b8eeff69') as contract_address                                     
union select 'Serendale_Blue Pet Egg'                  as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x9678518e04fe02fb30b55e2d0e554e26306d0892') as contract_address                                  
union select 'Serendale_Grey Pet Egg'                  as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x95d02c1dc58f05a015275eb49e107137d9ee81dc') as contract_address                                  
union select 'Serendale_Golden Egg'                    as contract_name, 'defi-kingdoms' as organization,'dfk-items'    as sub_type, lower('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148') as contract_address                                    
union select 'Serendale_QuestCore'                     as contract_name, 'defi-kingdoms' as organization,'dfk-games'    as sub_type, lower('0x5100bd31b822371108a0f63dcfb6594b9919eaf4') as contract_address
union select 'Serendale_Foraging'                      as contract_name, 'defi-kingdoms' as organization,'dfk-games'    as sub_type, lower('0x3132c76acf2217646fb8391918d28a16bd8a8ef4') as contract_address
union select 'Serendale_Fishing'                       as contract_name, 'defi-kingdoms' as organization,'dfk-games'    as sub_type, lower('0xe259e8386d38467f0e7ffedb69c3c9c935dfaefc') as contract_address
union select 'Serendale_WishingWell'                   as contract_name, 'defi-kingdoms' as organization,'dfk-games'    as sub_type, lower('0xf5ff69f4ac4a851730668b93fc408bc1c49ef4ce') as contract_address
union select 'Serendale_UniswapV2Factory'              as contract_name, 'defi-kingdoms' as organization,'dfk-market'   as sub_type, lower('0x9014b937069918bd319f80e8b3bb4a2cf6faa5f7') as contract_address
union select 'Serendale_UniswapV2Router02'             as contract_name, 'defi-kingdoms' as organization,'dfk-market'   as sub_type, lower('0x24ad62502d1c652cc7684081169d04896ac20f30') as contract_address
union select 'Serendale_JewelToken'                    as contract_name, 'defi-kingdoms' as organization,'dfk-tokens'   as sub_type, lower('0x72cb10c6bfa5624dd07ef608027e366bd690048f') as contract_address
union select 'Serendale_xJEWEL'                        as contract_name, 'defi-kingdoms' as organization,'dfk-tokens'   as sub_type, lower('0xa9ce83507d872c5e1273e745abcfda849daa654f') as contract_address
union select 'Serendale_Banker'                        as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x3685ec75ea531424bbe67db11e07013abeb95f1e') as contract_address
union select 'Serendale_MasterGardener'                as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xdb30643c71ac9e2122ca0341ed77d09d5f99f924') as contract_address
union select 'Serendale_Airdrop'                       as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xa678d193fecc677e137a00fefb43a9ccffa53210') as contract_address
union select 'Serendale_Profiles'                      as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xabd4741948374b1f5dd5dd7599ac1f85a34cacdd') as contract_address
union select 'Serendale_Hero'                          as contract_name, 'defi-kingdoms' as organization,'dfk-hero'     as sub_type, lower('0x5f753dcdf9b1ad9aabc1346614d1f4746fd6ce5c') as contract_address
union select 'Serendale_DFKGold'                       as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x3a4edcf3312f44ef027acfd8c21382a5259936e7') as contract_address
union select 'Serendale_AuctionHouse'                  as contract_name, 'defi-kingdoms' as organization,'dfk-auction'  as sub_type, lower('0x13a65b9f8039e2c032bc022171dc05b30c3f2892') as contract_address
union select 'Serendale_summoning'                     as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x65dea93f7b886c33a78c10343267dd39727778c2') as contract_address
union select 'Serendale_ShvasRune'                     as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x66f5bfd910cd83d3766c4b39d13730c911b2d286') as contract_address
union select 'Serendale_MeditationCircle'              as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x0594d86b2923076a2316eaea4e1ca286daa142c1') as contract_address
union select 'Dev Fund'                                as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xa4b9a93013a5590db92062cf58d4b0ab4f35dbfb') as contract_address
union select 'Marketing Fund'                          as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x3875e5398766a29c1b28cc2068a0396cba36ef99') as contract_address
union select 'Founders Wallet'                         as contract_name, 'defi-kingdoms' as organization,'dfk-founder'  as sub_type, lower('0x79f0d0670d17a89f509ad1c16bb6021187964a29') as contract_address
union select 'Old Dev Fund'                            as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x1e3b6b278ba3b340d4be7321e9be6dfed0121eac') as contract_address
union select 'Frisky Fox'                              as contract_name, 'defi-kingdoms' as organization,'dfk-founder'  as sub_type, lower('0x17d717eb3dd20a202dce9e8e396a444db1af1d28') as contract_address
union select 'Sinstar Necro'                           as contract_name, 'defi-kingdoms' as organization,'dfk-founder'  as sub_type, lower('0xa76ea4f96136af0ff23e7cc426bfc21e451ff9f5') as contract_address
union select 'Professor Tango'                         as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x03b5c81d9759eb3ca12b2201891e61ee4bdfbb7a') as contract_address
union select 'OgreAbroad'                              as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xfe6f41ef98fba9cd1d0e7f9a7d58069374517264') as contract_address
union select 'Tailchakra'                              as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x2a23ee4d575499ec9ac58dcfd3960c5d3f1f0d3b') as contract_address
union select 'Payment service team and contractors'    as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0x6ca68d6df270a047b12ba8405ec688b5df42d50c') as contract_address
union select 'Cross-Chain Liquidity Fund'              as contract_name, 'defi-kingdoms' as organization,'dfk-todo'     as sub_type, lower('0xa3f87fbcc69d2f97f528266c35b713e4bb12f962') as contract_address

-- TOOD WRITE MORE STUFFS
union select 'antonyip'                                as contract_name, 'undefined'     as organization,'user-address' as sub_type, lower('0x0ba43bae4613e03492e4c17af3b014b6c3202b9d') as contract_address
