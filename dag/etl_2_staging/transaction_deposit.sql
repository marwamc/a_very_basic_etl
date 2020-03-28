-- load to staging_transaction
INSERT INTO
data_staging.transaction_deposit
SELECT
    transaction_id::INT
    , contract_id::INT
    , transaction_status
    , transaction_amount::decimal(10,2)
    , transaction_date::TIMESTAMPTZ
    , etl_time::TIMESTAMPTZ
FROM data_raw.transaction
WHERE transaction_type = 'DEPOSIT'
;
