#!/bin/bash

echo "token_name"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x9edb3da18be4b03857f3d39f83e5c6aad67bc148",
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
            "to": "0x9edb3da18be4b03857f3d39f83e5c6aad67bc148",
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
            "to": "0x9edb3da18be4b03857f3d39f83e5c6aad67bc148",
            "data": "0x313ce567"
        },
        "latest"
    ],
    "id": 1
}'
