{{ config(materialized='incremental', unique_key="CONCAT_WS('-', contract_name, contract_address)", tags=['playground', 'ant_labels']) }}

-- https://github.com/DefiKingdoms/contracts
-- https://discord.com/channels/861728723991527464/896870883468136469/896870927382507531
      select 'UniswapV2Factory'  as contract_name, 'defi-kingdoms' as organization, lower('0x9014B937069918bd319f80e8B3BB4A2cf6FAA5F7') as contract_address
UNION select 'UniswapV2Router02' as contract_name, 'defi-kingdoms' as organization, lower('0x24ad62502d1C652Cc7684081169D04896aC20f30') as contract_address
UNION select 'JewelToken'        as contract_name, 'defi-kingdoms' as organization, lower('0x72Cb10C6bfA5624dD07Ef608027E366bd690048F') as contract_address
UNION select 'xJewel'            as contract_name, 'defi-kingdoms' as organization, lower('0xA9cE83507D872C5e1273E745aBcfDa849DAA654F') as contract_address
UNION select 'Bank'              as contract_name, 'defi-kingdoms' as organization, lower('0xA9cE83507D872C5e1273E745aBcfDa849DAA654F') as contract_address
UNION select 'Banker'            as contract_name, 'defi-kingdoms' as organization, lower('0x3685Ec75Ea531424Bbe67dB11e07013ABeB95f1e') as contract_address
UNION select 'MasterGardener'    as contract_name, 'defi-kingdoms' as organization, lower('0xDB30643c71aC9e2122cA0341ED77d09D5f99F924') as contract_address
UNION select 'Airdrop'           as contract_name, 'defi-kingdoms' as organization, lower('0xa678d193fEcC677e137a00FEFb43a9ccffA53210') as contract_address
UNION select 'Profiles'          as contract_name, 'defi-kingdoms' as organization, lower('0xabD4741948374b1f5DD5Dd7599AC1f85A34cAcDD') as contract_address
UNION SELECT 'Hero'              as contract_name, 'defi-kingdoms' as organization, lower('0x5F753dcDf9b1AD9AabC1346614D1f4746fd6Ce5C') as contract_address                                          
UNION SELECT 'Gaias Tears'       as contract_name, 'defi-kingdoms' as organization, lower('0x24eA0D436d3c2602fbfEfBe6a16bBc304C963D04') as contract_address                                  
UNION SELECT 'DFK Gold'          as contract_name, 'defi-kingdoms' as organization, lower('0x3a4edcf3312f44ef027acfd8c21382a5259936e7') as contract_address                                      
UNION SELECT 'Ambertaffy'        as contract_name, 'defi-kingdoms' as organization, lower('0x6e1bC01Cc52D165B357c42042cF608159A2B81c1') as contract_address                                    
UNION SELECT 'Darkweed'          as contract_name, 'defi-kingdoms' as organization, lower('0x68EA4640C5ce6cC0c9A1F17B7b882cB1cBEACcd7') as contract_address                                      
UNION SELECT 'Goldvein'          as contract_name, 'defi-kingdoms' as organization, lower('0x600541aD6Ce0a8b5dae68f086D46361534D20E80') as contract_address                                      
UNION SELECT 'Ragweed'           as contract_name, 'defi-kingdoms' as organization, lower('0x043F9bd9Bb17dFc90dE3D416422695Dd8fa44486') as contract_address                                       
UNION SELECT 'Redleaf'           as contract_name, 'defi-kingdoms' as organization, lower('0x094243DfABfBB3E6F71814618ace53f07362a84c') as contract_address                                       
UNION SELECT 'Rockroot'          as contract_name, 'defi-kingdoms' as organization, lower('0x6B10Ad6E3b99090De20bF9f95F960addC35eF3E2') as contract_address                                      
UNION SELECT 'Swift-Thistle'     as contract_name, 'defi-kingdoms' as organization, lower('0xCdfFe898E687E941b124dfB7d24983266492eF1d') as contract_address                                 
UNION SELECT 'Bloater'           as contract_name, 'defi-kingdoms' as organization, lower('0x78aED65A2Cc40C7D8B0dF1554Da60b38AD351432') as contract_address                                       
UNION SELECT 'Ironscale'         as contract_name, 'defi-kingdoms' as organization, lower('0xe4Cfee5bF05CeF3418DA74CFB89727D8E4fEE9FA') as contract_address                                     
UNION SELECT 'Lanterneye'        as contract_name, 'defi-kingdoms' as organization, lower('0x8Bf4A0888451C6b5412bCaD3D9dA3DCf5c6CA7BE') as contract_address                                    
UNION SELECT 'Redgill'           as contract_name, 'defi-kingdoms' as organization, lower('0xc5891912718ccFFcC9732D1942cCD98d5934C2e1') as contract_address                                       
UNION SELECT 'Sailfish'          as contract_name, 'defi-kingdoms' as organization, lower('0xb80A07e13240C31ec6dc0B5D72Af79d461dA3A70') as contract_address                                      
UNION SELECT 'Shimmerskin'       as contract_name, 'defi-kingdoms' as organization, lower('0x372CaF681353758f985597A35266f7b330a2A44D') as contract_address                                   
UNION SELECT 'Silverfin'         as contract_name, 'defi-kingdoms' as organization, lower('0x2493cfDAcc0f9c07240B5B1C4BE08c62b8eEff69') as contract_address                                     
UNION SELECT 'Shvas Rune'        as contract_name, 'defi-kingdoms' as organization, lower('0x66F5BfD910cd83d3766c4B39d13730C911b2D286') as contract_address                                    
UNION SELECT 'Blue Pet Egg'      as contract_name, 'defi-kingdoms' as organization, lower('0x9678518e04Fe02FB30b55e2D0e554E26306d0892') as contract_address                                  
UNION SELECT 'Grey Pet Egg'      as contract_name, 'defi-kingdoms' as organization, lower('0x95d02C1Dc58F05A015275eB49E107137D9Ee81Dc') as contract_address                                  
UNION SELECT 'Golden Egg'        as contract_name, 'defi-kingdoms' as organization, lower('0x9edb3Da18be4B03857f3d39F83e5C6AAD67bc148') as contract_address                                    

-- TOOD WRITE MORE STUFFS
UNION select 'antonyip'          as contract_name, 'undefined'     as organization, lower('0x0ba43bae4613e03492e4c17af3b014b6c3202b9d') as contract_address
