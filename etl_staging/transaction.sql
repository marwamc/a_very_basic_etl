-- load to staging_transaction
INSERT INTO
data_staging.transaction(transaction_id,contract_id,transaction_status,transaction_type,transaction_amount,transaction_date,etl_time)
SELECT
    transaction_id::INT
    , contract_id::INT
    , transaction_status
    , transaction_type
    , transaction_amount::decimal(10,2)
    , transaction_date::TIMESTAMP
    , etl_time::TIMESTAMP
FROM data_raw.transaction
WHERE etl_time > '2019-12-01';
