# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := start
.DELETE_ON_ERROR:
.SUFFIXES:

# VARS
PROJ_DIR := $(PWD)
PROJ_NAME := peg_etl
DB_NAME := peg_db
DB_USER := peg
DB_PWD := bubudaah

# TARGETS
build:
	docker build -t ${PROJ_NAME} .

stop:
	-docker stop ${PROJ_NAME}
	-docker rm ${PROJ_NAME}

db-volume: build
	docker volume create peg_etl_db_data

db-shell: db
	docker exec -it ${PROJ_NAME} /bin/bash

db: stop build
	docker run -d \
	--name ${PROJ_NAME} \
	-p 5436:5432 \
	-v ${PROJ_DIR}:/app/peg_etl \
	-e POSTGRES_DB=${DB_NAME} \
	-e POSTGRES_USER=${DB_USER} \
	-e POSTGRES_PASSWORD=${DB_PWD} \
	--mount source=peg_etl_db_data,destination=/var/lib/postgresql/data \
	${PROJ_NAME}:latest
	docker ps -a

ping:
	docker exec -it ${PROJ_NAME} psql -U ${DB_USER} -d ${DB_NAME}

etl:
	-$(MAKE) db
	# execute the makefile inside the dag dir
	$(MAKE) -C dag
