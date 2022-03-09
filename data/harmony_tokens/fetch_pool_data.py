import requests
import json
import unicodedata

def remove_control_characters(s):
    return "".join(ch for ch in s if unicodedata.category(ch)[0]!="C")

def results_to_str(d):
    j = json.loads(d)
    hex_string = j["result"][2:]
    bytes_obj = bytes.fromhex(hex_string)
    val = bytes_obj.decode('UTF-8')
    val = remove_control_characters(val).strip()
    return val

def queryHmy(method, params):
    payload = '{"jsonrpc": "2.0","method": "'+ method +'","params": ['+ params + ', "latest"], "id": 1}'
    header = {'Content-type': 'application/json'}
    r = requests.post('https://api.harmony.one', headers=header, data=payload)
    #print (r.request.body)
    return r.text

def get_decimals(tx):
    method = 'hmy_call'
    data = '0x313ce567'
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    j = json.loads(d)
    hex_string = j["result"][2:]
    bytes_obj = bytes.fromhex(hex_string)
    val = int.from_bytes(bytes_obj, "big")
    return val

def get_symbol(tx):
    method = 'hmy_call'
    data = '0x95d89b41'
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    val = results_to_str(d)
    return val

def get_name(tx):
    method = 'hmy_call'
    data = '0x06fdde03'
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    val = results_to_str(d)
    return val

def get_csv_line(addr):
    dec = get_decimals(addr)
    sym = get_symbol(addr)
    nam = get_name(addr)
    fin = addr + "," + nam + "," + sym + "," + str(dec)
    return fin

r = get_csv_line('0xd1069122ce76aca9ef66188b3543ef1ff17e8f8c')
print(r)


