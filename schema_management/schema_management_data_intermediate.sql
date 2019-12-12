-- schema
CREATE schema IF NOT EXISTS data_intermediate;

-- customer payment summary
CREATE TABLE IF NOT EXISTS
data_intermediate.contract_payment_summary(
  contract_id INT NOT NULL,
  total_paid decimal(10,2) NOT NULL,
  number_payments_made INT,
  earliest_payment_date TIMESTAMP,
  latest_payment_date TIMESTAMP,
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (contract_id)
);
