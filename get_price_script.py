   

import pandas as pd
import requests
import datetime as dt
import os
import snowflake.connector as sf
from snowflake.connector.pandas_tools import write_pandas


#will need to install pandas on the docker image

#Grabbing all of the contracts available on coingecko and the platforms the exist on
coin_list = "https://api.coingecko.com/api/v3/coins/list?include_platform=true"
response = requests.get(coin_list)
response = response.json()
df1 = pd.json_normalize(response)


#Isolating to just the Harmony Contracts we need
df2 = df1.dropna(subset = ["platforms.harmony-shard-0"])
df4 = df2.drop(
    [
 'platforms.polygon-pos',
 'platforms.avalanche',
 'platforms.binance-smart-chain',
 'platforms.fantom',
 'platforms.xdai',
 'platforms.kardiachain',
 'platforms.moonriver',
 'platforms.tron',
 'platforms.huobi-token',
 'platforms.sora',
 'platforms.polkadot',
 'platforms.chiliz',
 'platforms.komodo',
 'platforms.cardano',
 'platforms.optimistic-ethereum',
 'platforms.ardor',
 'platforms.qtum',
 'platforms.stellar',
 'platforms.arbitrum-one',
 'platforms.cronos',
 'platforms.solana',
 'platforms.osmosis',
 'platforms.algorand',
 'platforms.celo',
 'platforms.aurora',
 'platforms.eos',
 'platforms.neo',
 'platforms.terra',
 'platforms.Bitcichain',
 'platforms.waves',
 'platforms.okex-chain',
 'platforms.',
 'platforms.ronin',
 'platforms.icon',
 'platforms.smartbch',
 'platforms.nem',
 'platforms.bitshares',
 'platforms.binancecoin',
 'platforms.iotex',
 'platforms.fuse',
 'platforms.kucoin-community-chain',
 'platforms.hoo',
 'platforms.zilliqa',
 'platforms.klay-token',
 'platforms.boba',
 'platforms.secret',
 'platforms.tezos',
 'platforms.fusion-network',
 'platforms.xrp',
 'platforms.cosmos',
 'platforms.telos',
 'platforms.gochain',
 'platforms.vechain',
 'platforms.bitcoin-cash',
 'platforms.tomochain',
 'platforms.nuls',
 'platforms.metis-andromeda',
 'platforms.elrond',
 'platforms.stratis',
 'platforms.kava',
 'platforms.kusama',
 'platforms.omni',
 'platforms.metaverse-etp',
 'platforms.nxt',
 'platforms.enq-enecuum',
 'platforms.ontology',
 'platforms.factom',
 'platforms.wanchain',
 'platforms.rootstock',
 'platforms.openledger',
 'platforms.vite']
 ,axis=1
 )

#Taking the contracts and putting them into a list to set up the price API Query
contract_address_list = []
for x in df4['platforms.harmony-shard-0']:
    contract_address_list.append(x)

#Creating the API Query, can uncomment out the extended_api_suffix to get market_cap and 24 hour volume, still working on ETL for that
#Syntax for query url is: simple/token_price/platformid/comma seperated list of contracts (created above)/api_suffix 
api_prefix =  "https://api.coingecko.com/api/v3/simple/token_price/harmony-shard-0?contract_addresses=0x72cb10c6bfa5624dd07ef608027e366bd690048f"
#extended_api_suffix = "&vs_currencies=usd&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true"
api_suffix = "&vs_currencies=usd"
for y in contract_address_list:
   api_prefix = api_prefix + "%2C" + y
api_url = api_prefix + api_suffix

#ETL on the API response to get into address,usd_price,time_stamp
response = requests.get(api_url)
response = response.json()
df2 = pd.json_normalize(response)
df2 = df2.transpose()
df2 = df2.reset_index()
df2 = df2.rename(columns= {"index": "address", 0: "usd_price"})
df2["address"] = df2["address"].str[:42]
df2["timestamp"] = dt.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')

#Writing into the snowflake - need to fix datetime issues. Address & Price work
conn = sf.connect(
    user = os.getenv('SF_USERNAME'),
    password = os.getenv('SF_PASSWORD'),
    account = os.getenv('SF_ACCOUNT'),
    warehouse = os.getenv('SF_WAREHOUSE'),
    database = os.getenv('SF_DATABASE'),
    schema = os.getenv('SF_SCHEMA')
)
cs = conn.cursor()

print(df2)
try:

    # convert to a string list of tuples
    df2 = str(list(df2.itertuples(index=False, name=None)))
    # get rid of the list elements so it is a string tuple list
    df2 = df2.replace('[','').replace(']','')
    print(df2)    
    # set up execute
    cs.execute(
         """ INSERT INTO """ + "TOKEN_USD_PRICES_MR" + """
             VALUES """ + df2 + """

         """)     
finally:
    cs.close()
conn.close()

