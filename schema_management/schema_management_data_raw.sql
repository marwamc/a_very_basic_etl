-- raw data schema
CREATE schema IF NOT EXISTS data_raw;

-- raw customer
CREATE TABLE IF NOT EXISTS
data_raw.customer(
  customer_id char(25),
  first_name char(25),
  last_name char(25),
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (customer_id)
);

-- raw contract
CREATE TABLE IF NOT EXISTS
data_raw.contract(
  contract_id char(25),
  customer_id char(25),
  product_id char(25),
  created_at char(100),
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (contract_id)
);

-- raw product
CREATE TABLE IF NOT EXISTS
data_raw.product(
  product_id char(25),
  product_name char(25),
  deposit char(25),
  total_price char(25),
  payment_frequency char(25),
  payment_amount char(25),
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (product_id)
);

-- raw transaction
CREATE TABLE IF NOT EXISTS
data_raw.transaction(
  transaction_id char(25),
  contract_id char(25),
  transaction_status char(25),
  transaction_type char(25),
  transaction_amount char(25),
  transaction_date char(25),
  etl_time char(50) DEFAULT NOW(),
  PRIMARY KEY (transaction_id)
);


-- only if necessary
DROP TABLE data_raw.customer;
DROP TABLE data_raw.contract;
DROP TABLE data_raw.product;
DROP TABLE data_raw.transaction;

