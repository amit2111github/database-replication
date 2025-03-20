FROM postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=postgres 
ENV PGDATA=/var/lib/postgresql/data
copy ./slave.init.sql /docker-entrypoint-initdb.d/master-init.sh
