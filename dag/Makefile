# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := etl_4_finance
.DELETE_ON_ERROR:
.SUFFIXES:

#VARS
CTN_NAME := peg_etl
docker_exec := docker exec -it peg_etl psql -e -U postgres -d peg_db

# TARGETS
schema_init:
	${docker_exec} -f dag/schema_management/data_raw.sql
	${docker_exec}  -f dag/schema_management/data_staging.sql
	${docker_exec}  -f dag/schema_management/data_intermediate.sql
	${docker_exec}  -f dag/schema_management/finance.sql

etl_1_raw: schema_init
	${docker_exec}  -f dag/etl_1_raw/etl_raw_data.sql

etl_2_staging: etl_1_raw
	${docker_exec}  -f dag/etl_2_staging/contract.sql
	${docker_exec}  -f dag/etl_2_staging/customer.sql
	${docker_exec}  -f dag/etl_2_staging/product.sql
	${docker_exec}  -f dag/etl_2_staging/transaction_deposit.sql
	${docker_exec}  -f dag/etl_2_staging/transaction_payment.sql

etl_3_intermediate: etl_2_staging
	${docker_exec}  -f dag/etl_3_intermediate/contract_start_date.sql
	${docker_exec}  -f dag/etl_3_intermediate/contract_payment_summary.sql
	${docker_exec}  -f dag/etl_3_intermediate/contract_projection.sql

etl_4_finance: etl_3_intermediate
	${docker_exec}  -f dag/etl_4_finance/contract_status.sql

analysis:
	${docker_exec}  -x -c "SELECT * FROM data_raw.customer"

