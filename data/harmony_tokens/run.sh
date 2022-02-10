#!/bin/bash

echo "token_name"
curl -H 'Content-Type:application/json' -X POST "https://api.harmony.one" --data '{
    "jsonrpc": "2.0",
    "method": "hmy_call",
    "params": [
        {
            "to": "0x6D4f4bC32df561a35C05866051CbE9C92759Da29",
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
            "to": "0x6D4f4bC32df561a35C05866051CbE9C92759Da29",
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
            "to": "0x6D4f4bC32df561a35C05866051CbE9C92759Da29",
            "data": "0x313ce567"
        },
        "latest"
    ],
    "id": 1
}'
