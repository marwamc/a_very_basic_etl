-- staging data schema
CREATE schema data_staging;

DROP TABLE data_staging.customer;
DROP TABLE data_staging.contract;
DROP TABLE data_staging.product;
DROP TABLE data_staging.transaction;

-- staging customer
CREATE TABLE data_staging.customer(
  customer_id INT NOT NULL,
  first_name char(25) NOT NULL,
  last_name char(25) NOT NULL,
  etl_time TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (customer_id)
);

-- staging contract
CREATE TABLE data_staging.contract(
  contract_id INT NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL,
  etl_time TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (contract_id)
);

-- staging product
CREATE TABLE data_staging.product(
  product_id INT NOT NULL,
  product_name char(25) NOT NULL,
  deposit decimal(10,2) NOT NULL,
  total_price decimal(10,2) NOT NULL,
  payment_frequency char(25) NOT NULL,
  payment_amount decimal(10,2),
  etl_time TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (product_id)
);

-- staging transaction payment
CREATE TABLE data_staging.transaction_payment(
  transaction_id INT NOT NULL,
  contract_id INT NOT NULL,
  transaction_status char(25),
  transaction_amount decimal(10,2),
  transaction_date TIMESTAMPTZ NOT NULL,
  etl_time TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (transaction_id)
);


-- staging transaction payment
CREATE TABLE data_staging.transaction_deposit(
  transaction_id INT NOT NULL,
  contract_id INT NOT NULL,
  transaction_status char(25),
  transaction_amount decimal(10,2),
  transaction_date TIMESTAMPTZ NOT NULL,
  etl_time TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (transaction_id)
);





