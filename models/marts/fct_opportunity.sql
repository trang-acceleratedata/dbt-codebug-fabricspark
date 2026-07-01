-- Freshness-miss fixture (rollback case).
-- load_date is genuinely stale SOURCE data (the last successful load, 2026-06-29;
-- the 2026-06-30 scheduled run was skipped — see vd_audit_load_history). It is NOT
-- a code literal: the mart correctly passes the source's load_date through, so there
-- is no code defect to fix. runbook-reload-lakehouse-mart rebuilds the mart, but the
-- freshness-restored post-condition (`count(*) where load_date >= current_date` > 0)
-- still returns 0 — a rebuild cannot invent a fresh scheduled load — so the rollback
-- (git checkout; the ephemeral schema is disposable, always succeeds) fires and the
-- incident escalates.
select
    opportunity_id,
    stage_name,
    amount,
    case when stage_name = 'Won' then amount else 0 end as won_amount,
    cast(load_date as date) as load_date
from {{ ref('opportunity') }}
