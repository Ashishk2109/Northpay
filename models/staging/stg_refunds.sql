CREATE OR REPLACE TABLE stg_refunds AS
SELECT
	refund_id,
    transaction_id,
    merchant_id,
    CAST(refund_amount AS DECIMAL(18,2)) AS refund_amount_original,
    currency,
    CAST(refund_amount_cad AS DECIMAL(18,2)) AS refund_amount_cad,
    refund_type,
    refund_reason,
    CAST(created_at AS DATE) AS refund_date,
    created_at,
    LOWER(status) AS status,
    same_day_refund

FROM raw_refunds;

SELECT COUNT(*) FROM raw_refunds;
SELECT COUNT(*) FROM stg_refunds;

SELECT DISTINCT status FROM stg_refunds;