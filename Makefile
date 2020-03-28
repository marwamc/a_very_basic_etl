# Top section copied from http://clarkgrubb.com/makefile-style-guide
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DEFAULT_GOAL := start
.DELETE_ON_ERROR:
.SUFFIXES:

# STATIC VARS
PROJ_DIR := $(PWD)
PROJ_NAME := peg_etl
DB_NAME := peg_db
DB_USER := peg
DB_PWD := bubudaah
VOLUME_NAME := peg_etl_db_data

# INTERPOLATED VARS
VOLUME_EXISTS := $(shell docker volume ls | grep peg)
CONTAINER_IS_RUNNING := $(shell docker ps --format {{.Image}} | grep peg_etl)

# TARGETS
build: db-volume
	docker build -t ${PROJ_NAME} .

stop:
	-docker stop ${PROJ_NAME}
	-docker rm ${PROJ_NAME}

db-volume:
ifdef VOLUME_EXISTS
	@echo "Volume exists: ${VOLUME_NAME}"
else
	docker volume create ${VOLUME_NAME}
endif

db:
ifdef CONTAINER_IS_RUNNING
	@echo "Container already running"
	@docker ps -a
else
	$(MAKE) stop
	$(MAKE) build
	docker run -d \
	--name ${PROJ_NAME} \
	-p 5432:5432 \
	-v ${PROJ_DIR}:/app/peg_etl \
	${PROJ_NAME}:latest
endif
#--mount source=peg_etl_db_data,destination=/var/lib/postgresql/data \

psql:
	docker exec -it ${PROJ_NAME} psql -U postgres -d peg_db

shell: db
	docker exec -it ${PROJ_NAME} /bin/bash

etl: db
	# execute the makefile inside the dag dir
	cd dag && $(MAKE) etl_4

analysis: db
	cd dag && $(MAKE) analysis

cleanup:
	docker rm -vf $(docker ps -a -q)
	docker rmi -f $(docker images -a -q)
