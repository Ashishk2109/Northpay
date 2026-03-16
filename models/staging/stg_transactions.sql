CREATE OR REPLACE TABLE stg_transactions AS
 SELECT transaction_id, merchant_id, created_at,
 CAST(created_at AS DATE) AS transaction_date,
 CAST(amount AS DECIMAL (18,2)) AS amount_original,
 CAST(amount_cad AS DECIMAL(18,2)) AS amount_cad,
 currency, LOWER(status) AS status,
 payment_method, card_last4, is_retry, customer_id, description, processor_response_code
FROM raw_transactions;

SELECT COUNT(*) FROM raw_transactions;
SELECT COUNT(*) FROM stg_transactions;

DESCRIBE stg_transactions;

SELECT DISTINCT status FROM stg_transactions;