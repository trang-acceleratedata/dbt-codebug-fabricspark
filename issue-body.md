<!-- vd-meta
engine: dbt
artifact: fct_opportunity
load_id: dbt-build-2026-06-30-1330
error_code: VOLUME_ANOMALY
error_message: "Row-count anomaly: fct_opportunity dropped ~60% vs the trailing 7-day baseline. The dbt build itself reported success (run_results status=success), so the local artifacts do NOT explain the drop — run history / load volumes in the lakehouse audit table are needed to localize it."
severity: p2
-->

## Volume anomaly: `fct_opportunity` row count dropped ~60%

`fct_opportunity` materialized with far fewer rows than its trailing baseline,
but **the dbt build succeeded** — `target/run_results.json` shows `status=success`
with no test failure. The local tree therefore can't explain the drop.

To localize it, inspect the **lakehouse audit / load-history table** (per-`load_id`
row counts and freshness timestamps over recent runs) — was an upstream load
short, did a partition fail to land, did the source shrink? This is diagnosis
evidence the pinned working tree does not carry.
