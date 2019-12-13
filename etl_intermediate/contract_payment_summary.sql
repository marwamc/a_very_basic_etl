-- contract payment summary
INSERT INTO
data_intermediate.contract_payment_summary
SELECT DISTINCT
  tx.contract_id
  , SUM(tx.transaction_amount) OVER(PARTITION by contract_id) AS total_paid
  , COUNT(tx.transaction_id) OVER(PARTITION by contract_id) AS number_payments_made
  , MIN(tx.transaction_date) OVER(PARTITION by contract_id) AS earliest_payment_date
  , MIN(tx.transaction_date) OVER(PARTITION by contract_id) AS latest_payment_date
FROM data_staging.transaction_payment tx
WHERE tx.transaction_amount IS NOT NULL
;