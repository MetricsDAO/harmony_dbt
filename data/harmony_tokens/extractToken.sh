#!/bin/bash

echo "token_name"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x17f3b5240c4a71a3bbf379710f6fa66b9b51f224",
            "data": "0x06fdde03"
        },
        "latest"
    ],
    "id": 1
}'

# 0x18160ddd -- total supply

echo "token_symbol"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x17f3b5240c4a71a3bbf379710f6fa66b9b51f224",
            "data": "0x95d89b41"
        },
        "latest"
    ],
    "id": 1
}'
echo "token_decimal"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x17f3b5240c4a71a3bbf379710f6fa66b9b51f224",
            "data": "0x313ce567"
        },
        "latest"
    ],
    "id": 1
}'
