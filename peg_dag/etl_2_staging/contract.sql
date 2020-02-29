-- load to staging_contract
INSERT INTO
data_staging.contract
SELECT
    contract_id::INT
    , customer_id::INT
    , product_id::INT
    , created_at::TIMESTAMPTZ
    , etl_time::TIMESTAMPTZ
FROM data_raw.contract
WHERE etl_time > '2019-12-01'
;
