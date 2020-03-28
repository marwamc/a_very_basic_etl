# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := etl_4_finance
.DELETE_ON_ERROR:
.SUFFIXES:

#VARS
CTN_NAME := peg_etl
docker_exec := docker exec -it 01415f448050 psql -U peg -d peg_db

# TARGETS
schema-init:
	${docker_exec} -f 'schema_management/data_raw.sql'
	${docker_exec}  -f 'schema_management/data_staging.sql'
	${docker_exec}  -f 'schema_management/data_intermediate.sql'
	${docker_exec}  -f 'schema_management/etl_4_finance.sql'

etl_1_raw: schema-init
	${docker_exec}  -f 'etl_1_raw/etl_raw_data.sql

etl_2_staging: etl_1_raw
	${docker_exec}  -f 'etl_2_staging/contract.sql'
	${docker_exec}  -f 'etl_2_staging/customer.sql'
	${docker_exec}  -f 'etl_2_staging/product.sql'
	${docker_exec}  -f 'etl_2_staging/transaction_deposit.sql'
	${docker_exec}  -f 'etl_2_staging/transaction_payment.sql'

etl_3_intermediate: etl_2_staging
	${docker_exec}  -f 'etl_3_intermediate/contract_start_date.sql'
	${docker_exec}  -f 'etl_3_intermediate/contract_payment_summary.sql'
	${docker_exec}  -f 'etl_3_intermediate/contract_projection.sql'

etl_4_finance: etl_3_intermediate
	${docker_exec}  -f 'etl_4_finance/contract_status.sql'
