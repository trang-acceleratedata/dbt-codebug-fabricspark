---
id: runbook-reload-lakehouse-mart
title: Reload a stale Fabric lakehouse mart (dbt-fabricspark)
engine-types: [dbt]
root-cause-patterns: [freshness miss, stale mart, mart not refreshed, data freshness SLA breach]
rate-limit: 3 per hour
auto-execute-eligible: true
runbook-class: resolution
---

Rebuilds a stale mart in the Fabric lakehouse via dbt-fabricspark against the
per-intent ephemeral schema. Non-destructive (writes only the ephemeral schema).

## Preconditions
- `artifact-state` — `fct_opportunity` last run shows error/freshness fired.

## Execution Steps
1. `lakehouse-rebuild` — `dbt build --select fct_opportunity --target ephemeral_dev --project-dir . --profiles-dir .` (dbt-fabricspark, broker-authed).

## Post-conditions
- `freshness-restored` — the rebuilt mart has at least one row dated today: `SELECT count(*) FROM fct_opportunity WHERE load_date >= current_date` returns `> 0` against the ephemeral schema. Fails when the source is genuinely stale.

## Rollback Plan
- `restore-tree` — `git checkout -- .`. The ephemeral schema is per-intent and disposable, so no warehouse rollback is needed; always succeeds.
