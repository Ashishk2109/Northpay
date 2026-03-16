## Table Overview

### raw_transactions
Columns:
- DESCRIBE raw_transactions;
┌─────────────────────────┬─────────────┬─────────┬─────────┬─────────┬─────────┐
│       column_name       │ column_type │  null   │   key   │ default │  extra  │
│         varchar         │   varchar   │ varchar │ varchar │ varchar │ varchar │
├─────────────────────────┼─────────────┼─────────┼─────────┼─────────┼─────────┤
│ transaction_id          │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ merchant_id             │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ created_at              │ TIMESTAMP   │ YES     │ NULL    │ NULL    │ NULL    │
│ amount                  │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ currency                │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ amount_cad              │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ status                  │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ payment_method          │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ card_last4              │ BIGINT      │ YES     │ NULL    │ NULL    │ NULL    │
│ is_retry                │ BOOLEAN     │ YES     │ NULL    │ NULL    │ NULL    │
│ customer_id             │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ description             │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ processor_response_code │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
├─────────────────────────┴─────────────┴─────────┴─────────┴─────────┴─────────┤
│ 13 rows                                                             6 columns │
└───────────────────────────────────────────────────────────────────────────────┘

### raw_refunds
Columns:
- 
┌───────────────────┬─────────────┬─────────┬─────────┬─────────┬─────────┐
│    column_name    │ column_type │  null   │   key   │ default │  extra  │
│      varchar      │   varchar   │ varchar │ varchar │ varchar │ varchar │
├───────────────────┼─────────────┼─────────┼─────────┼─────────┼─────────┤
│ refund_id         │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ transaction_id    │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ merchant_id       │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ refund_amount     │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ currency          │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ refund_amount_cad │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ refund_type       │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ refund_reason     │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ created_at        │ TIMESTAMP   │ YES     │ NULL    │ NULL    │ NULL    │
│ status            │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ same_day_refund   │ BOOLEAN     │ YES     │ NULL    │ NULL    │ NULL    │
├───────────────────┴─────────────┴─────────┴─────────┴─────────┴─────────┤
│ 11 rows                                                       6 columns │
└─────────────────────────────────────────────────────────────────────────┘

### raw_merchants
Columns:
-
┌────────────────┬─────────────┬─────────┬─────────┬─────────┬─────────┐
│  column_name   │ column_type │  null   │   key   │ default │  extra  │
│    varchar     │   varchar   │ varchar │ varchar │ varchar │ varchar │
├────────────────┼─────────────┼─────────┼─────────┼─────────┼─────────┤
│ merchant_id    │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ merchant_name  │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ category       │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ fee_plan_id    │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ status         │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ onboarded_date │ DATE        │ YES     │ NULL    │ NULL    │ NULL    │
│ country        │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ province       │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
└────────────────┴─────────────┴─────────┴─────────┴─────────┴─────────┘

### raw_fee_plans
Columns:
-
┌─────────────────┬─────────────┬─────────┬─────────┬─────────┬─────────┐
│   column_name   │ column_type │  null   │   key   │ default │  extra  │
│     varchar     │   varchar   │ varchar │ varchar │ varchar │ varchar │
├─────────────────┼─────────────┼─────────┼─────────┼─────────┼─────────┤
│ fee_plan_id     │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ plan_name       │ VARCHAR     │ YES     │ NULL    │ NULL    │ NULL    │
│ base_rate_pct   │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ fixed_fee_cad   │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ fx_markup_pct   │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
│ monthly_cap_cad │ DOUBLE      │ YES     │ NULL    │ NULL    │ NULL    │
└─────────────────┴─────────────┴─────────┴─────────┴─────────┴─────────┘

Total Transactions: 50000

### Status Distribution: 
How many are completed?
-  completed  43981
How many are failed?
- failed  3996  
How many are pending?
- pending   2023
% of completion rate?
 -> 87.96
% of failed transaction rate?
 -> 7.99
% of pending transaction rate?
 -> 4.05


### Currency Distribution:
 CAD - 27552 
 USD - 14956
 EUR - 7492

## Retry Logic Analysis

### 1 Retry Distribution
Query Used:
```sql
SELECT is_retry, COUNT(*) 
FROM raw_transactions
GROUP BY is_retry;

Results:

is_retry = false → 48,542
is_retry = true → 1,458

Analysis:

Total transactions = 50,000

Retry transactions represent ~2.9% of total transactions.

The vast majority of transactions are original attempts.

Retry logic is used sparingly, likely triggered only after specific failure cases.

### 2 Retry Behavior by Status
Query Used:

SELECT status, is_retry, COUNT(*) 
FROM raw_transactions
GROUP BY status, is_retry
ORDER BY 3 DESC;

Results:

Non-Retry Transactions:
completed → 42,690
failed → 3,886
pending → 1,966

Retry Transactions:
completed → 1,291
failed → 110
pending → 57

Observations & Business Insights

Retry Success Effectiveness:

1,291 out of 1,458 retries were completed.

Retry success rate ≈ 88.5%.

This indicates the retry mechanism is highly effective in recovering failed transactions.

Failure Behavior:

Failed retries (110) are relatively low.
Most retries convert into successful transactions.

Business Impact:
Retry logic likely prevents revenue loss from transient failures.
Without retries, an additional 1,291 transactions may have been lost.
The system's retry design appears efficient and financially beneficial.

### Explore Refunds
 
## Refund Analysis

### 1 Total Refunds Volume
Query Used:
'''sql
SELECT COUNT(*) FROM raw_refunds;

Result:
Total refund records: 3,518

Analysis:
There are 3,518 refund entries in the system.
Total transactions = 50,000 (from previous analysis).
Refund rate ≈ 7.0% of total transactions.
Refund activity is present but not excessively high.

### 2 Refunds Per Transaction (Partial Refund Check)

### 2 Refunds per Transaction

Query Used:

SELECT 
    transaction_id,
    COUNT(*) as refund_count
FROM raw_refunds
GROUP BY transaction_id
ORDER BY refund_count DESC
LIMIT 10;

Result:
Maximum refund_count observed: 1
No transactions have more than one refund entry.

Analysis:
Partial refunds do NOT exist in this dataset.
Each refunded transaction has exactly one refund record.
Revenue adjustments can be modeled with a 1:1 relationship between transaction and refund.
This simplifies transformation logic in staging models.

### 3 Refund Exceed Check (Critical Financial Integrity Test)


Query Used:

SELECT 
    r.transaction_id,
    t.amount_cad,
    SUM(r.refund_amount) AS total_refund
FROM raw_refunds r
JOIN raw_transactions t
ON r.transaction_id = t.transaction_id
GROUP BY 1,2
HAVING SUM(r.refund_amount) > t.amount_cad;

Result:
0 rows returned.

Analysis:
No refund exceeds the original transaction amount.
Financial integrity is maintained.
No evidence of over-refunding or duplicate refund errors.


### 4 Orphan Refund Check (Data Consistency Validation)

### 4 Orphan Refund Validation

Query Used:

SELECT COUNT(*)
FROM raw_refunds r
LEFT JOIN raw_transactions t
ON r.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;

Result:
0 orphan refunds detected.

Analysis:
Every refund is properly linked to an existing transaction.
Referential integrity between raw_refunds and raw_transactions is preserved.
No data corruption or broken foreign key relationships detected.

### 5 Same-Day Refund Behavior

### 5 Same-Day Refund Distribution

Query Used:

SELECT same_day_refund, COUNT(*)
FROM raw_refunds
GROUP BY 1;

Result:
same_day_refund = true → 438
same_day_refund = false → 3,080

Analysis:
Approximately 12.4% of refunds occur on the same day as the transaction.
The majority (87.6%) occur after the transaction date.

This may indicate:
Post-delivery disputes
Customer dissatisfaction after product/service usage
Delayed processing or settlement timing

### Merchant Status Distribution'

Query Used:

SELECT status, COUNT(*) 
FROM raw_merchants
GROUP BY status;

Results:
active → 9
suspended → 1

Analysis:
Total merchants: 10
Only 1 merchant is currently suspended.
Suspended merchants may require special treatment in financial reporting.
Revenue inclusion rules must clarify whether historical transactions remain valid after suspension.

### Suspended Merchant Validation

### Suspended Merchant Check
Query Used:

SELECT COUNT(*)
FROM raw_merchants
WHERE merchant_id = 'M007';

Result:

Merchant M007 exists and is the only suspended merchant.

### Fee Plan Exploration

## Fee Plan Structure
Query Used:

SELECT * FROM raw_fee_plans;

Available Fee Plans:

Standard
base_rate_pct: 2.9%
fixed_fee_cad: 0.30
fx_markup_pct: 1.5%
monthly_cap_cad: NULL

Premium
base_rate_pct: 1.9%
fixed_fee_cad: 0.20
fx_markup_pct: 0.8%

monthly_cap_cad: NULL

Enterprise
base_rate_pct: 1.2%
fixed_fee_cad: 0.10
fx_markup_pct: 0.5%
monthly_cap_cad: 5000 CAD

Startup
base_rate_pct: 3.5%
fixed_fee_cad: 0.25
fx_markup_pct: 2.0%
monthly_cap_cad: NULL

### Interpretation of Fee Components

- base_rate_pct → percentage applied to transaction amount.
- fixed_fee_cad → flat fee per transaction.
- fx_markup_pct → additional percentage applied for currency conversion.
- monthly_cap_cad → maximum total fees per month (applies to Enterprise plan only).

The Enterprise plan includes a monthly cap of 5000 CAD, which may limit revenue beyond a threshold.