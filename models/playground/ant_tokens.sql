{{ config(materialized='incremental', unique_key="CONCAT_WS('-', contract_name, contract_address)", tags=['playground', 'ant_tokens']) }}

-- https://github.com/DefiKingdoms/contracts
-- https://discord.com/channels/861728723991527464/896870883468136469/896870927382507531
      select '1USDC'                                   as contract_name, 6  as decimals, lower('0x985458e523db3d53125813ed68c274899e9dfab4') as contract_address                                  
union select 'WONE'                                    as contract_name, 18 as decimals, lower('0xcf664087a5bb0237a0bad6742852ec6c8d69a27a') as contract_address                                  
union select 'Serendale_Gaia Tears'                    as contract_name, 0  as decimals, lower('0x24ea0d436d3c2602fbfefbe6a16bbc304c963d04') as contract_address                                  
union select 'Serendale_Ambertaffy'                    as contract_name, 0  as decimals, lower('0x6e1bc01cc52d165b357c42042cf608159a2b81c1') as contract_address                                    
union select 'Serendale_Darkweed'                      as contract_name, 0  as decimals, lower('0x68ea4640c5ce6cc0c9a1f17b7b882cb1cbeaccd7') as contract_address                                      
union select 'Serendale_Goldvein'                      as contract_name, 0  as decimals, lower('0x600541ad6ce0a8b5dae68f086d46361534d20e80') as contract_address                                      
union select 'Serendale_Ragweed'                       as contract_name, 0  as decimals, lower('0x043f9bd9bb17dfc90de3d416422695dd8fa44486') as contract_address                                       
union select 'Serendale_Redleaf'                       as contract_name, 0  as decimals, lower('0x094243dfabfbb3e6f71814618ace53f07362a84c') as contract_address                                       
union select 'Serendale_Rockroot'                      as contract_name, 0  as decimals, lower('0x6b10ad6e3b99090de20bf9f95f960addc35ef3e2') as contract_address                                      
union select 'Serendale_Swift-Thistle'                 as contract_name, 0  as decimals, lower('0xcdffe898e687e941b124dfb7d24983266492ef1d') as contract_address                                 
union select 'Serendale_Bloater'                       as contract_name, 0  as decimals, lower('0x78aed65a2cc40c7d8b0df1554da60b38ad351432') as contract_address                                       
union select 'Serendale_Ironscale'                     as contract_name, 0  as decimals, lower('0xe4cfee5bf05cef3418da74cfb89727d8e4fee9fa') as contract_address                                     
union select 'Serendale_Lanterneye'                    as contract_name, 0  as decimals, lower('0x8bf4a0888451c6b5412bcad3d9da3dcf5c6ca7be') as contract_address                                    
union select 'Serendale_Redgill'                       as contract_name, 0  as decimals, lower('0xc5891912718ccffcc9732d1942ccd98d5934c2e1') as contract_address                                       
union select 'Serendale_Sailfish'                      as contract_name, 0  as decimals, lower('0xb80a07e13240c31ec6dc0b5d72af79d461da3a70') as contract_address                                      
union select 'Serendale_Shimmerskin'                   as contract_name, 0  as decimals, lower('0x372caf681353758f985597a35266f7b330a2a44d') as contract_address                                   
union select 'Serendale_Silverfin'                     as contract_name, 0  as decimals, lower('0x2493cfdacc0f9c07240b5b1c4be08c62b8eeff69') as contract_address                                     
union select 'Serendale_Blue Pet Egg'                  as contract_name, 0  as decimals, lower('0x9678518e04fe02fb30b55e2d0e554e26306d0892') as contract_address                                  
union select 'Serendale_Grey Pet Egg'                  as contract_name, 0  as decimals, lower('0x95d02c1dc58f05a015275eb49e107137d9ee81dc') as contract_address                                  
union select 'Serendale_Golden Egg'                    as contract_name, 0  as decimals, lower('0x9edb3da18be4b03857f3d39f83e5c6aad67bc148') as contract_address                                    
union select 'Serendale_QuestCore'                     as contract_name, 0  as decimals, lower('0x5100bd31b822371108a0f63dcfb6594b9919eaf4') as contract_address
union select 'Serendale_Foraging'                      as contract_name, 0  as decimals, lower('0x3132c76acf2217646fb8391918d28a16bd8a8ef4') as contract_address
union select 'Serendale_Fishing'                       as contract_name, 0  as decimals, lower('0xe259e8386d38467f0e7ffedb69c3c9c935dfaefc') as contract_address
union select 'Serendale_WishingWell'                   as contract_name, 0  as decimals, lower('0xf5ff69f4ac4a851730668b93fc408bc1c49ef4ce') as contract_address
union select 'Serendale_JewelToken'                    as contract_name, 18 as decimals, lower('0x72cb10c6bfa5624dd07ef608027e366bd690048f') as contract_address
union select 'Serendale_xJEWEL'                        as contract_name, 18 as decimals, lower('0xa9ce83507d872c5e1273e745abcfda849daa654f') as contract_address
