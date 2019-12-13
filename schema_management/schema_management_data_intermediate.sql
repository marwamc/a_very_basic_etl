-- schema
CREATE schema data_intermediate;

-- only if needed
DROP TABLE data_intermediate.contract_payment_summary;
DROP TABLE data_intermediate.contract_projection;
DROP TABLE data_intermediate.deposit;


-- customer payment summary
CREATE TABLE data_intermediate.contract_payment_summary(
  contract_id INT NOT NULL,
  total_paid decimal(10,2) NOT NULL,
  number_payments_made INT,
  earliest_payment_date TIMESTAMPTZ,
  latest_payment_date TIMESTAMPTZ,
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (contract_id)
);


-- contract projection
CREATE TABLE IF NOT EXISTS
data_intermediate.contract_projection(
  contract_id INT NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  contract_start_date TIMESTAMPTZ NOT NULL,
  projected_completion_date TIMESTAMPTZ,
  projected_total_number_payments INT NOT NULL,
  projected_number_payments INT NOT NULL,
  projected_paid_amount decimal(10,2),  -- projected balance as of projection date
  projected_outstanding_balance decimal(10,2),  -- projected balance as of projection date
  projection_date TIMESTAMPTZ DEFAULT NOW(),
  etl_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (contract_id)
);

-- contract deposit
CREATE TABLE IF NOT EXISTS
data_intermediate.deposit(
  transaction_id INT NOT NULL,
  contract_id INT NOT NULL,
  deposit_date TIMESTAMPTZ NOT NULL,
  deposit_amount decimal(10,2),
  etl_time TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (contract_id)
);





