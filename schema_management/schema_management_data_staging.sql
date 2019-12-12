-- staging data schema
CREATE schema IF NOT EXISTS data_staging;

-- staging customer
CREATE TABLE IF NOT EXISTS
data_staging.customer(
  customer_id INT NOT NULL,
  first_name char(25) NOT NULL,
  last_name char(25) NOT NULL,
  etl_time TIMESTAMP NOT NULL,
  PRIMARY KEY (customer_id)
);

-- staging contract
CREATE TABLE IF NOT EXISTS
data_staging.contract(
  contract_id INT NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL,
  etl_time TIMESTAMP NOT NULL,
  PRIMARY KEY (contract_id)
);

-- staging product
CREATE TABLE IF NOT EXISTS
data_staging.product(
  product_id INT NOT NULL,
  product_name char(25) NOT NULL,
  deposit decimal(10,2) NOT NULL,
  total_price decimal(10,2) NOT NULL,
  payment_frequency char(25) NOT NULL,
  payment_amount decimal(10,2) NOT NULL,
  etl_time TIMESTAMP NOT NULL,
  PRIMARY KEY (product_id)
);

-- staging transaction
CREATE TABLE IF NOT EXISTS
data_staging.transaction(
  transaction_id INT NOT NULL,
  contract_id INT NOT NULL,
  transaction_status char(25),
  transaction_type char(25),
  transaction_amount decimal(10,2),
  transaction_date TIMESTAMP NOT NULL,
  etl_time TIMESTAMP NOT NULL,
  PRIMARY KEY (transaction_id)
);



