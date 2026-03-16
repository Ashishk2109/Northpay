CREATE OR REPLACE TABLE stg_fee_plans AS
SELECT
    fee_plan_id,
    plan_name,

    CAST(base_rate_pct AS DECIMAL(5,4)) AS base_rate_pct,
    CAST(fixed_fee_cad AS DECIMAL(10,2)) AS fixed_fee_cad,
    CAST(fx_markup_pct AS DECIMAL(5,4)) AS fx_markup_pct,

    CAST(monthly_cap_cad AS DECIMAL(10,2)) AS monthly_cap_cad

FROM raw_fee_plans;

SELECT * FROM stg_fee_plans;

DESCRIBE stg_fee_plans;