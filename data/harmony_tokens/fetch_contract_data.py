import requests
import json
import unicodedata
from csv import reader,writer

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

def addr_trim(d):
    # trim left-padding of 0x000000000000000000000000  (26 chars)
    j = json.loads(d)
    hex_string = j["result"][26:]
    new_addr = '0x' + hex_string
    return new_addr

def get_token0(tx):
    method = 'hmy_call'
    data = '0x0dfe1681'  #4-byte function signature for "token0()"
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    j = json.loads(d)
    val = addr_trim(d)
    return val

def get_token1(tx):
    method = 'hmy_call'
    data = '0xd21220a7'  #4-byte function signature for "token1()"
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    j = json.loads(d)
    val = addr_trim(d)
    return val

def get_decimals(tx):
    method = 'hmy_call'
    data = '0x313ce567'  #4-byte function signature for "decimals()"
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    j = json.loads(d)
    hex_string = j["result"][2:]
    bytes_obj = bytes.fromhex(hex_string)
    val = int.from_bytes(bytes_obj, "big")
    return val

def get_symbol(tx):
    method = 'hmy_call'
    data = '0x95d89b41'  #4-byte function signature for "symbol()"
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    val = results_to_str(d)
    return val

def get_name(tx):
    method = 'hmy_call'
    data = '0x06fdde03' #4-byte function signature for "name()"
    params = '{ "to": "'+ tx +'", "data": "'+ data +'"}'
    d = queryHmy(method, params)
    val = results_to_str(d)
    return val

def get_token_csv_line(addr):
    dec = get_decimals(addr)
    sym = get_symbol(addr)
    nam = get_name(addr)
    fin = addr + "," + nam + "," + sym + "," + str(dec)
    return fin

def get_pool_csv_line(addr):
    t0 = get_token0(addr)
    t0sym = get_symbol(t0)
    t1 = get_token1(addr)
    t1sym = get_symbol(t1)
    nam = t0sym + "-" + t1sym
    fin = addr + "," + nam + "," + t0 + "," + t1
    return fin

#r = get_csv_line('0xd1069122ce76aca9ef66188b3543ef1ff17e8f8c')
#r = get_token_csv_line('0xe01502db14929b7733e7112e173c3bcf566f996e')
#print(r)
def backfill_pools():
    csv_file = open("backfill_pools_data.csv", "w")
    write_obj = writer(csv_file)

    # open file in read mode
    with open('tmp_backfill_pools.csv', 'r') as read_obj:
        # pass the file object to reader() to get the reader object
        csv_reader = reader(read_obj)
        # Iterate over each row in the csv using reader object
        for row in csv_reader:
            # row variable is a list that represents a row in csv
            try:
                print(row)
                r = get_pool_csv_line(row[0])
                print(r)
                csv_file.write(r + "\n")
                #write_obj.writerow(r)
            except:
                print("ERROR on " + row[0])

    csv_file.close()

def backfill_tokens():
    csv_file = open("backfill_tokens_data.csv", "w")
    write_obj = writer(csv_file)

    # open file in read mode
    with open('tmp_backfill_tokens.csv', 'r') as read_obj:
        # pass the file object to reader() to get the reader object
        csv_reader = reader(read_obj)
        # Iterate over each row in the csv using reader object
        for row in csv_reader:
            # row variable is a list that represents a row in csv
            try:
                print(row)
                r = get_token_csv_line(row[0])
                print(r)
                csv_file.write(r + "\n")
                #write_obj.writerow(r)
            except:
                print("ERROR on " + row[0])

    csv_file.close()

backfill_tokens()

#r = get_pool_csv_line('0x29fc4d7d55a3cd08f0971e3b009642f56efb8c60')
#print(r)


