CREATE OR REPLACE TABLE stg_merchants AS
SELECT
    merchant_id,
    merchant_name,
    category,
    fee_plan_id,

    LOWER(status) AS status,

    CASE 
        WHEN LOWER(status) = 'suspended' THEN TRUE
        ELSE FALSE
    END AS is_suspended,

    onboarded_date,
    country,
    province

FROM raw_merchants;


SELECT * FROM stg_merchants;


SELECT status, COUNT(*) 
FROM stg_merchants
GROUP BY status;