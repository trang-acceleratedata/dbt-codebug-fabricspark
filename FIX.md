# Expected fix

`models/marts/fct_opportunity.sql` — gate `won_amount` on the won stage:

    case when stage_name = 'Won' then amount else 0 end as won_amount

After the fix, `dbt build` / `dbt test` is green: the singular test
`assert_won_amount_zero_when_not_won` returns zero rows.
