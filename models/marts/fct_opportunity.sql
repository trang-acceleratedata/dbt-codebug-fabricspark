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
