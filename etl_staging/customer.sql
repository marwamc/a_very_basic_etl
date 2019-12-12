-- customer
INSERT INTO
data_staging.customer(customer_id,first_name,last_name,etl_time)
SELECT
    customer_id::INT
    , first_name
    , last_name
    , etl_time::TIMESTAMP
FROM data_raw.customer
WHERE etl_time > '2019-12-01';
