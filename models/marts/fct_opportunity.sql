-- Volume-anomaly fixture.
-- The dbt build is CLEAN (won_amount is correct, the DQ test passes), so local
-- artifacts do NOT explain the ~60% row-count drop the alert reported. Diagnosis
-- must consult the lakehouse audit table (vd_audit_load_history: the 2026-06-30
-- load fell to 4150 rows vs a ~10400 baseline) via lakehouse_query to localize the
-- drop, then escalate — there is no safe local remedy for a source-volume drop.
select
    opportunity_id,
    stage_name,
    amount,
    case when stage_name = 'Won' then amount else 0 end as won_amount
from (
    select 1 as opportunity_id, 'Won'          as stage_name, 100.0 as amount union all
    select 2 as opportunity_id, 'Prospecting'  as stage_name, 250.0 as amount union all
    select 3 as opportunity_id, 'Closed Lost'  as stage_name,  75.0 as amount
) as raw_opportunity
