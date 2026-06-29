-- BUG: won_amount must be the amount only when the opportunity is Won,
-- and 0 otherwise. This sets it unconditionally, so non-won rows leak amount.
select
    opportunity_id,
    stage_name,
    amount,
    amount as won_amount
from (
    select 1 as opportunity_id, 'Won'          as stage_name, 100.0 as amount union all
    select 2 as opportunity_id, 'Prospecting'  as stage_name, 250.0 as amount union all
    select 3 as opportunity_id, 'Closed Lost'  as stage_name,  75.0 as amount
) as raw_opportunity
