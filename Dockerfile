FROM postgres:latest

ENV POSTGRES_USER=peg
ENV POSTGRES_PASSWORD=bubudaah
ENV POSTGRES_DB=peg_db

WORKDIR /app/peg_etl/
