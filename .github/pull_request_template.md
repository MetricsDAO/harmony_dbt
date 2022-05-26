# Description

- Changed column name from "GAS" to "GAS_LIMIT" for TXS table in NEAR and updated corresponding yaml
- Format change due to dbt formatter extension

@forgxyz @chuxinh

NOTES: `full-refresh` is needed for txs table

# Tests

- [✔️] Please provide evidence of your successful `dbt run` / `dbt test` here

root@30a128358363:/harmony# dbt run -s txs --full-refresh
Running with dbt=0.21.1
Found 45 models, 389 tests, 0 snapshots, 0 analyses, 180 macros, 0 operations, 8 seed files, 21 sources, 0 exposures

22:10:11 | Concurrency: 4 threads (target='dev')
22:10:11 |
22:10:12 | 1 of 1 START incremental model DEV.txs............................... [RUN]
22:10:33 | 1 of 1 OK created incremental model DEV.txs.......................... [SUCCESS 1 in 21.61s]
22:10:33 |
22:10:33 | Finished running 1 incremental model in 26.63s.

Completed successfully

Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
root@30a128358363:/harmony# dbt run -s txs
Running with dbt=0.21.1
Found 45 models, 389 tests, 0 snapshots, 0 analyses, 180 macros, 0 operations, 8 seed files, 21 sources, 0 exposures

22:22:16 | Concurrency: 4 threads (target='dev')
22:22:16 |
22:22:16 | 1 of 1 START incremental model DEV.txs............................... [RUN]
23:11:12 | 1 of 1 OK created incremental model DEV.txs.......................... [SUCCESS 1 in 2936.15s]
23:11:12 |
23:11:12 | Finished running 1 incremental model in 2941.15s.

Completed successfully

Done. PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1

- [✔️] Any comparison between `prod` and `dev` for any schema change
  `prod`: txs table have column "gas"
  `dev`: txs table have column "gas_limit

# Checklist

- [✔️] Follow [dbt style guide](https://github.com/dbt-labs/corp/blob/main/dbt_style_guide.md)
- [✔️] Tag the person(s) responsible for reviewing proposed changes
- [✔️] Notes to deployment, if a `full-refresh` is needed for any table
- [✔️] Run `dbt docs generate` to update the documentation files if this PR is changing the models in any way.
