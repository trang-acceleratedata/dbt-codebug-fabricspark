-- Freshness-miss fixture (rollback case).
-- The scheduled Fabric run on 2026-06-30 was SKIPPED (see vd_audit_load_history),
-- so the mart still carries the last successful load's stale load_date
-- (2026-06-29) — this is DATA, an operational miss, not a code bug (won_amount is
-- correct, the DQ test passes). runbook-reload-lakehouse-mart rebuilds the mart,
-- but the freshness-restored post-condition
-- (`count(*) where load_date >= current_date` > 0) still returns 0 — a rebuild
-- cannot invent a fresh scheduled load — so the rollback (git checkout; the
-- ephemeral schema is disposable, always succeeds) fires and the incident escalates.
select
    opportunity_id,
    stage_name,
    amount,
    case when stage_name = 'Won' then amount else 0 end as won_amount,
    cast('2026-06-29' as date) as load_date
from (
    select 1 as opportunity_id, 'Won'          as stage_name, 100.0 as amount union all
    select 2 as opportunity_id, 'Prospecting'  as stage_name, 250.0 as amount union all
    select 3 as opportunity_id, 'Closed Lost'  as stage_name,  75.0 as amount
) as raw_opportunity
