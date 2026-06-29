-- Fails (returns rows) while non-won opportunities carry a non-zero won_amount.
select opportunity_id, stage_name, amount, won_amount
from {{ ref('fct_opportunity') }}
where stage_name != 'Won' and won_amount != 0
