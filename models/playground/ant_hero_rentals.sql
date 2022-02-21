with
summon_tx as (
    select 
        tx_hash,
        data,
        substr(data,0,10) as funcsig,
        len(data) as dlen,
        from_address as summoneer
    from harmony.dev.txs
    where block_timestamp > current_date - 30
        and (to_address = '0x65dea93f7b886c33a78c10343267dd39727778c2' or to_address = '0xf4d3ae202c9ae516f7eb1db5aff19bf699a5e355')
        --and funcsig = '0xc2b40631'
        --and tx_hash = '0x2232bd2135afcbfcb5869cc126ba85c562ce4d8f9aadf715592b83a9cb8ec6f7'
),
debug_costs_to_summon AS (
    select 
        evm_contract_address,
        tx_hash,
        topics,
        event_inputs:value / pow(10,18) as amount
        
    from harmony.dev.logs
    where tx_hash in (select tx_hash from summon_tx)
        and event_name = 'Transfer'
        and not (topics[2] = '0x0000000000000000000000005f753dcdf9b1ad9aabc1346614d1f4746fd6ce5c' -- hero contract
          or topics[2] = '0x000000000000000000000000a9ce83507d872c5e1273e745abcfda849daa654f' -- xjewel
          or topics[2] = '0x000000000000000000000000000000000000000000000000000000000000dead'
          or topics[2] = '0x000000000000000000000000f4d3ae202c9ae516f7eb1db5aff19bf699a5e355' -- summon contract
          or topics[2] = '0x00000000000000000000000079f0d0670d17a89f509ad1c16bb6021187964a29' -- frisky
          or topics[2] = '0x000000000000000000000000a4b9a93013a5590db92062cf58d4b0ab4f35dbfb' -- dev fund
          or topics[2] = '0x0000000000000000000000003875e5398766a29c1b28cc2068a0396cba36ef99') -- marketing fund
        and (topics[1] = '0x000000000000000000000000f4d3ae202c9ae516f7eb1db5aff19bf699a5e355' or topics[1] = '0x00000000000000000000000065dea93f7b886c33a78c10343267dd39727778c2')
),
costs_to_summon AS (
    select 
        evm_contract_address,
        tx_hash,
        sum(event_inputs:value) as amount
    from harmony.dev.logs
    where tx_hash in (select tx_hash from summon_tx)
        and event_name = 'Transfer'

    group by 1, 2
),
required_costs_to_summon AS (
    select 
        evm_contract_address,
        tx_hash,
        sum(event_inputs:value) as amount
    from harmony.dev.logs
    where tx_hash in (select tx_hash from summon_tx)
        and event_name = 'Transfer'
        and not (topics[2] = '0x0000000000000000000000005f753dcdf9b1ad9aabc1346614d1f4746fd6ce5c' -- hero contract
          or topics[2] = '0x000000000000000000000000a9ce83507d872c5e1273e745abcfda849daa654f' -- xjewel
          or topics[2] = '0x000000000000000000000000000000000000000000000000000000000000dead'
          or topics[2] = '0x000000000000000000000000f4d3ae202c9ae516f7eb1db5aff19bf699a5e355' -- summon contract
          or topics[2] = '0x00000000000000000000000079f0d0670d17a89f509ad1c16bb6021187964a29' -- frisky
          or topics[2] = '0x000000000000000000000000a4b9a93013a5590db92062cf58d4b0ab4f35dbfb' -- dev fund
          or topics[2] = '0x0000000000000000000000003875e5398766a29c1b28cc2068a0396cba36ef99') -- marketing fund
        and (topics[1] = '0x000000000000000000000000f4d3ae202c9ae516f7eb1db5aff19bf699a5e355' or topics[1] = '0x00000000000000000000000065dea93f7b886c33a78c10343267dd39727778c2')
    group by 1, 2
),
final as (
    select
        logs.block_timestamp,
        --concat('0x',substr(logs.data,3,64)) as crystal_id,
        java_hextoint(substr(summon_table.data,3+8,64)) as mainHeroID,
        java_hextoint(substr(summon_table.data,3+8+64,64)) as rentedHeroID,
        --summon_table.dlen,
        --summon_table.funcsig,
        t.amount / pow(10,18) as jewel_cost,
        nvl(r.amount,0) / pow(10,18) as rental_cost,
        --jewel_cost - jewel_dfk_cost as rental_cost,
        --summon_table.summoneer,
        logs.tx_hash
    from harmony.dev.logs logs
    left join summon_tx as summon_table
        on summon_table.tx_hash = logs.tx_hash
    left join costs_to_summon as t
        on t.tx_hash = logs.tx_hash and t.evm_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
    left join required_costs_to_summon as r
        on r.tx_hash = logs.tx_hash and r.evm_contract_address = '0x72cb10c6bfa5624dd07ef608027e366bd690048f'
    where logs.tx_hash in (select tx_hash from summon_tx)
        and block_timestamp > current_date - 30
        and logs.topics[0] = '0x4508aba30a57c0fc7f1d5da83dea7dd0c36368a7080d3a6652fcd5a58168f460'
)

select 
    rentedHeroid,
    count(rentedheroid) as c,
    avg(rental_cost)
from final
where rental_cost > 10
and rental_cost < 60
and rentedheroid > 2000
group by 1
order by c desc

