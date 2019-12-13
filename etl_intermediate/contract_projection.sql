-- contract projection
INSERT INTO 
data_intermediate.contract_projection
WITH

contract_start_date AS(
    SELECT
        ct.contract_id
        , coalesce(dt.deposit_date, ct.created_at) AS as_of
    FROM data_staging.contract ct
    LEFT JOIN data_staging.transaction_deposit dt
      ON dt.contract_id = ct.contract_id
),

contract_prep AS(
    SELECT
        ct.contract_id
        , csd.as_of AS contract_start_date
        , ((pd.total_price-pd.deposit)/pd.payment_amount)::INT AS projected_total_number_payments
        , csd.as_of + (((pd.total_price-pd.deposit)/pd.payment_amount)::INT || 'day')::INTERVAL AS projected_completion_date
        , least(date_part('day', now()-csd.as_of)::INT, ((pd.total_price-pd.deposit)/pd.payment_amount)::INT) AS projected_number_payments
        , pd.payment_amount
        , pd.total_price-pd.deposit AS financed_amount
        , pd.total_price
    FROM data_staging.contract ct
      LEFT JOIN data_staging.product pd
        ON pd.product_id = ct.product_id
      LEFT JOIN contract_start_date csd
        ON csd.contract_id = ct.contract_id
)

SELECT DISTINCT
    ct.contract_id
    , ct.customer_id
    , ct.product_id
    , ct.created_at AS contract_start_date
    , cp.projected_completion_date
    , cp.projected_total_number_payments
    , cp.projected_number_payments
    , least(cp.financed_amount, cp.payment_amount*cp.projected_number_payments) AS projected_paid_amount
    , greatest(0, cp.financed_amount - (cp.payment_amount*projected_number_payments)) AS projected_outstanding_balance
    , now() AS projection_date
    , now() AS etl_time
FROM data_staging.contract ct
  LEFT JOIN contract_prep cp
    ON cp.contract_id = ct.contract_id
  LEFT JOIN data_intermediate.deposit dt
    ON dt.contract_id = ct.contract_id
;