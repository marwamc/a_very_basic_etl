-- load to staging_contract
INSERT INTO
data_staging.contract(contract_id,customer_id,product_id,created_at,etl_time)
SELECT
    contract_id::INT
    , customer_id::INT
    , product_id::INT
    , created_at::TIMESTAMP
    , etl_time::TIMESTAMP
FROM data_raw.contract
WHERE etl_time > '2019-12-01';
