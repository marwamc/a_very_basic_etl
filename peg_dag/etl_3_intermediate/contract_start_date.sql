-- contract start date
INSERT INTO 
data_intermediate.contract_start_date
WITH

deposit_summary AS(
  SELECT DISTINCT
    contract_id
    , MIN(transaction_date) OVER(PARTITION by contract_id) AS earliest_deposit_date
  FROM data_staging.transaction_deposit
)

SELECT
  ct.contract_id
  , coalesce(ds.earliest_deposit_date, cps.earliest_payment_date, ct.created_at) AS as_of
FROM data_staging.contract ct
LEFT JOIN deposit_summary ds
  ON ds.contract_id = ct.contract_id
LEFT JOIN data_intermediate.contract_payment_summary cps
  ON cps.contract_id = ct.contract_id
;
