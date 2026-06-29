# dbt test failure: won_amount populated for non-won opportunities

**Pipeline:** sales_pipeline (Fabric lakehouse)
**Model:** `models/marts/fct_opportunity.sql`
**Failing test:** `assert_won_amount_zero_when_not_won`

The data test `assert_won_amount_zero_when_not_won` is failing on `fct_opportunity`:
it returns rows where `stage_name != 'Won'` but `won_amount != 0`. `won_amount`
must be the deal amount only when the opportunity is Won, and 0 otherwise.

Reproduce: `dbt test --select assert_won_amount_zero_when_not_won` (red).
The mart materializes to the Fabric lakehouse via the dbt-fabricspark adapter.
