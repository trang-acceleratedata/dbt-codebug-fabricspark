---
id: runbook-quarantine-lakehouse-mart
title: Quarantine a Fabric lakehouse mart (stop-gap)
engine-types: [dbt]
root-cause-patterns: [recurring data-quality failure, contract breach downstream impact, quarantine, stop-gap needed]
rate-limit: 3 per hour
auto-execute-eligible: true
runbook-class: mitigation
---

Temporary stop-gap for a recurring lakehouse data-quality failure: mark the mart
quarantined so downstream consumers stop reading bad data while a durable code
fix is filed. Does NOT fix root cause — a mitigation.

## Preconditions
- `artifact-state` — `fct_opportunity` last run shows a data-quality test failure.

## Execution Steps
1. `write-quarantine-marker` — `mkdir -p .quarantine && printf 'fct_opportunity quarantined pending durable fix\n' > .quarantine/fct_opportunity`.

## Post-conditions
- `quarantine-in-place` — `test -f .quarantine/fct_opportunity`. Passes ⇒ outcome `auto-mitigated-pending-durable-fix`.

## Rollback Plan
- `remove-marker` — `rm -f .quarantine/fct_opportunity`. Only invoked on post-condition failure.
