-- load to staging_product
INSERT INTO
data_staging.product(product_id,product_name,deposit,total_price,payment_frequency,etl_time)
SELECT
    product_id::INT
    , product_name
    , deposit::decimal(10,2)
    , total_price::decimal(10,2)
    , payment_frequency
    , payment_amount::decimal(10,2)
    , etl_time::TIMESTAMP
FROM data_raw.product
WHERE etl_time > '2019-12-01';
