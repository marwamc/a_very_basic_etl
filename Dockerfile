FROM postgres:latest

ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB peg_db

WORKDIR /app/peg_etl/
CMD [ "postgres" ]
