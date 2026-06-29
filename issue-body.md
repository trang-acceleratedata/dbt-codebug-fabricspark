<!-- vd-meta
engine: dbt
artifact: fct_opportunity
load_id: dbt-build-2026-06-29-fabric-0001
error_code: DATA_QUALITY
error_message: "Singular test assert_won_amount_zero_when_not_won failed: 2 rows where a not-won opportunity has a non-zero won_amount"
severity: p2
-->

## Data-quality failure: `fct_opportunity.won_amount` non-zero for non-won opportunities

The dbt build for `fct_opportunity` (Fabric lakehouse, dbt-fabricspark) passed the
model run but failed the singular test `assert_won_amount_zero_when_not_won`:
2 opportunities with `stage_name != 'Won'` report a non-zero `won_amount`. This is
a logic error in the model, not a transient or infra failure — no runbook re-run
will fix it; the model SQL must change. See `target/run_results.json` (the failing
test) and `models/marts/fct_opportunity.sql` in the working tree.
