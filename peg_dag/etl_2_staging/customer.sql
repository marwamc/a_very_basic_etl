-- load to staging_customer
INSERT INTO
data_staging.customer
SELECT
    customer_id::INT
    , first_name
    , last_name
    , etl_time::TIMESTAMPTZ
FROM data_raw.customer
WHERE etl_time > '2019-12-01'
;
