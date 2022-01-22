## Introduction
Data used to be extracted from dfkwiki.com (Site has now been gone due to founder shutting it down)

You should be able to extract the swaps based on trades done on this contract `0xe53bf78f8b99b6d356f93f41afb9951168cca2c6`

```
select * from harmony.prod.logs
where evm_contract_address = '0xe53bf78f8b99b6d356f93f41afb9951168cca2c6'
limit 10
```

NPC_VERSION column is an internal column I added for the future if DFK decides to modify the Swap prices.

Should be able to do something like

```
case when
block_number < 21900000 then '1' -- which npc price version to use
end as price_to_use,
case when price_to_use = '1' then (select price where version='1' and contract_address = <contract_address>) * item end
```
