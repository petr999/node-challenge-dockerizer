#!/bin/sh

# Before PostgreSQL can function correctly, the database cluster must be initialized:
initdb -D /var/lib/postgresql/data

# internal start of server in order to allow set-up using psql-client
# does not listen on external TCP/IP and waits until start finishes
pg_ctl -D "/var/lib/postgresql/data" -o "-c listen_addresses=''" -w start

# create a user or role
psql -d postgres -c "CREATE USER ${CHALLENGE_USER} WITH PASSWORD '${CHALLENGE_PASS}';" 

# create database 
psql -v ON_ERROR_STOP=1 -d postgres -c "CREATE DATABASE ${CHALLENGE_DB} OWNER '${CHALLENGE_USER}';"

# stop internal postgres server
pg_ctl -D "/var/lib/postgresql/data" -m fast -w stop

exec "$@"