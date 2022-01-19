#!/bin/bash

echo "token_name"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x872dd1595544ce22ad1e0174449c7ece6f0bb01b",
            "data": "0x06fdde03"
        },
        "latest"
    ],
    "id": 1
}'
# echo "token_symbol"
# curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
#     "jsonrpc": "2.0",
#     "method": "hmy_call",
#     "params": [
#         {
#             "to": "0x1771dec8d9a29f30d82443de0a69e7b6824e2f53",
#             "data": "0x95d89b41"
#         },
#         "latest"
#     ],
#     "id": 1
# }'
# echo "token_decimal"
# curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
#     "jsonrpc": "2.0",
#     "method": "hmy_call",
#     "params": [
#         {
#             "to": "0xA1f8b0E88c51a45E152934686270DDF4E3356278",
#             "data": "0x313ce567"
#         },
#         "latest"
#     ],
#     "id": 1
# }'
