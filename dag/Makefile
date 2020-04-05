# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := etl_4
.DELETE_ON_ERROR:
.SUFFIXES:

#VARS
CTN_NAME := peg_etl
docker_exec := docker exec -it peg_etl psql -eb -U postgres -d peg_db


# TARGETS
schema_init:
	${docker_exec} -f dag/schema_management/data_raw.sql
	${docker_exec}  -f dag/schema_management/data_staging.sql
	${docker_exec}  -f dag/schema_management/data_intermediate.sql
	${docker_exec}  -f dag/schema_management/finance.sql
	$(MAKE) sleep

etl_1: schema_init
	${docker_exec}  -f dag/etl_1_raw/etl_raw_data.sql
	$(MAKE) sleep


etl_2: etl_1
	#docker exec -it peg_etl bash -c " cat dag/etl_2_staging/*.sql | psql -eb -U postgres -d peg_db"
	${docker_exec}  -f dag/etl_2_staging/contract.sql
	${docker_exec}  -f dag/etl_2_staging/customer.sql
	${docker_exec}  -f dag/etl_2_staging/product.sql
	${docker_exec}  -f dag/etl_2_staging/transaction_deposit.sql
	${docker_exec}  -f dag/etl_2_staging/transaction_payment.sql
	$(MAKE) sleep

etl_3: etl_2
	${docker_exec}  -f dag/etl_3_intermediate/contract_start_date.sql
	${docker_exec}  -f dag/etl_3_intermediate/contract_payment_summary.sql
	${docker_exec}  -f dag/etl_3_intermediate/contract_deposit_summary.sql
	${docker_exec}  -f dag/etl_3_intermediate/contract_projection.sql

etl_4: etl_3
	${docker_exec}  -f dag/etl_4_finance/contract_status.sql

analysis:
	${docker_exec}  -x -c "SELECT * FROM finance.contract_status"

sleep:
	@echo "Will sleep for 2 seconds"
	$$(sleep 2)
