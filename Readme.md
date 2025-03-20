<h2>Database Replication</h2>
<p>I Spin 2 container , one as master and other as slave now in master at the db start-up made changes to posytgres.conf file and pg_ho</p>
<li>wal_level = replica" : enabled sending the wal records to standby server</li>
<li>max_wal_senders = 10 : max 10 server can received the WAL records concurrently</li>
<li>ot_standby = on : stand-by can do read even thought its performing WAL sync</li>
<li>PGPASSWORD="password" pg_basebackup -h pg-master -D "$PGDATA" -U replicator -P -R: this will basically do the db replication from primary replication</li>

