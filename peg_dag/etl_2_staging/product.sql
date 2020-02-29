-- load to staging_product
INSERT INTO
data_staging.product
SELECT
    product_id::INT
    , product_name
    , deposit::decimal(10,2)
    , total_price::decimal(10,2)
    , payment_frequency
    , payment_amount::decimal(10,2)
    , etl_time::TIMESTAMPTZ
FROM data_raw.product
WHERE etl_time > '2019-12-01';
