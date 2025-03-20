#!/bin/bash
set -e

echo "Configuring standby PostgreSQL database..."

# Stop PostgreSQL service
pg_ctl stop -D "$PGDATA"

# Remove default data directory
rm -rf "${PGDATA:?}" && mkdir -p "$PGDATA" && chown postgres:postgres "$PGDATA"

PGPASSWORD="password" pg_basebackup -h pg-master -D "$PGDATA" -U replicator -P -R

echo "starting the server again"
# Start PostgreSQL
pg_ctl start -D "$PGDATA"
