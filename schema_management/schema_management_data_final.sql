-- staging data schema
CREATE schema IF NOT EXISTS core_tables;

-- core customer
CREATE TABLE IF NOT EXISTS
core_tables.customer(
  customer_id INT NOT NULL,
  first_name char(25) NOT NULL,
  last_name char(25) NOT NULL,
  customer_as_of TIMESTAMP,
  customer_status char(25),
  contract_id INT[],
  PRIMARY KEY (customer_id)
);

-- core contract
CREATE TABLE IF NOT EXISTS
data_staging.contract(
  contract_id INT NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  outstanding_balance decimal(10,2),
  projected_outstanding_balance decimal(10,2),
  projected_completion_date TIMESTAMP,
  PRIMARY KEY (contract_id)
);





