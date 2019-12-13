-- staging data schema
CREATE schema IF NOT EXISTS core_tables;

-- core customer
CREATE TABLE IF NOT EXISTS
core_tables.customer(
  customer_id INT NOT NULL,
  first_name char(25) NOT NULL,
  last_name char(25) NOT NULL,
  customer_as_of TIMESTAMPTZ,
  customer_status char(25),
  contract_id INT[],
  PRIMARY KEY (customer_id)
);

-- core contract
CREATE TABLE IF NOT EXISTS
core_tables.contract_status(
  contract_id INT NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  contract_start_date TIMESTAMPTZ NOT NULL,
  projected_balance decimal(10,2),
  projected_paid_amount decimal(10,2),
  projected_completion_date TIMESTAMPTZ,
  projection_date TIMESTAMPTZ,
  PRIMARY KEY (contract_id)
);





