
-- finance contract status
INSERT INTO
finance.contract_status
SELECT
  0 AS contract_status
  , cpj.contract_id
  , 'peg'::text AS customer_name
  , pd.product_name
  , csd.as_of AS date_of_sale
  , pd.total_price - cps.total_paid AS total_outstanding_balance
  , cpj.projected_paid_amount AS outstanding_balance_to_date
  , cpj.projected_completion_date
  , now() AS etl_time
FROM data_staging.contract ct
  LEFT JOIN data_staging.product pd
    ON pd.product_id = ct.product_id
  JOIN data_intermediate.contract_start_date csd
    ON csd.contract_id = ct.contract_id
  JOIN data_intermediate.contract_projection cpj
    ON cpj.contract_id = ct.contract_id
  JOIN data_intermediate.contract_payment_summary cps
    ON cps.contract_id = ct.contract_id
;
