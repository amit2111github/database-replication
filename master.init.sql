#!/bin/bash
set -e

echo "Configuring primary PostgreSQL database for replication..."

# Allow replication connections
echo "wal_level = replica" >> /var/lib/postgresql/data/postgresql.conf
echo "max_wal_senders = 10" >> /var/lib/postgresql/data/postgresql.conf
echo "hot_standby = on" >> /var/lib/postgresql/data/postgresql.conf

# Create a replication user
psql -U postgres -d postgres -c "CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'password';"

echo "host replication replicator 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf

# Restart PostgreSQL to apply changes
pg_ctl restart -D "$PGDATA"