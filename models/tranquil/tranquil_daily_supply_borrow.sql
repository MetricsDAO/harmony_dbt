
{{
    config(
        materialized='table',
        unique_key="block_date||'-'||token_symbol",
        tags=['core', 'defi', 'amm', 'lending'],
        cluster_by=['block_date', 'token_symbol']
        )
}}

with

tranquil_markets_usd as (
    select 
        token_symbol,
        timestamp as block_date,
        price
    from {{ ref("tranquil_markets_tokenprice") }}
),

txns as (
    select 
        date_trunc('day', block_timestamp) as block_date,
        token_symbol,
        tx_type,
        sum(token_amount) as token_amount
    from {{ ref("tranquil_txs") }}
    group by 1,2,3
),

txns_typecols as (
    select
        m.*,
        zeroifnull(t1.token_amount) as deposit_token_amt,
        zeroifnull(t2.token_amount) as withdrawal_token_amt,
        zeroifnull(t3.token_amount) as borrow_token_amt,
        zeroifnull(t4.token_amount) as repayment_token_amt
    from tranquil_markets_usd as m
    left join txns t1 
        on m.block_date = t1.block_date
        and m.token_symbol = t1.token_symbol
        and t1.tx_type = 'Deposit'
    left join txns t2 
        on m.block_date = t2.block_date
        and m.token_symbol = t2.token_symbol
        and t2.tx_type = 'Withdrawal'
    left join txns t3
        on m.block_date = t3.block_date
        and m.token_symbol = t3.token_symbol
        and t3.tx_type = 'Borrow'
    left join txns t4
        on m.block_date = t4.block_date
        and m.token_symbol = t4.token_symbol
        and t4.tx_type = 'Repayment'
),

backfill_tvl as (

    select 
        tml.token_symbol,
        '2021-12-06 00:00:00.000' as block_date,
        0 as price,
        ( (l.event_inputs:cashPrior + l.event_inputs:totalBorrows) / pow(10,tml.decimals) ) as net_supplied_token_chg,
        (l.event_inputs:totalBorrows / pow(10,tml.decimals) ) as net_borrowed_token_chg
    from tranquil_market_labels tml
    left join logs l 
        on tml.first_tx = l.tx_hash
        and l.event_name = 'AccrueInterest'
),

deltas as (
    select 
        c.token_symbol,
        c.block_date,
        c.price,
        (c.deposit_token_amt - c.withdrawal_token_amt) as net_supplied_token_chg,
        (c.borrow_token_amt - c.repayment_token_amt) as net_borrowed_token_chg
    from txns_typecols c
),

add_backfill as (
    select * from deltas
    union all
    select * from backfill_tvl
),

running as (
    select
        c.*,
        (
            select sum(net_supplied_token_chg) 
                from add_backfill d
                where c.token_symbol = d.token_symbol
                    and c.block_date >= d.block_date
        ) as running_total_supplied_token,
        (
            select sum(net_borrowed_token_chg) 
                from add_backfill d2
                where c.token_symbol = d2.token_symbol
                    and c.block_date >= d2.block_date
        ) as running_total_borrowed_token
    from add_backfill as c
    order by 1,2
),

final as (
    select r.*,
        (net_supplied_token_chg * price) as net_supplied_usd_chg,
        (net_borrowed_token_chg * price) as net_borrowed_usd_chg,
        (running_total_supplied_token * price) as running_total_supplied_usd,
        (running_total_borrowed_token * price) as running_total_borrowed_usd
    from running as r
    order by 1,2
)

select * from final
