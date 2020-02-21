#!/bin/bash

# Create PostgreSQL cluster
if [[ ! -f "/etc/postgresql/10/main/postgresql.conf" ]]
then
    pg_createcluster 10 main --start
    sed -i 's/5432/54321/g' /etc/postgresql/10/main/postgresql.conf
    cp /etc/postgresql/10/main/*.conf /var/lib/postgresql/10/main/
fi

# Restart PostgreSQL and create koozic user
service postgresql restart
sleep 5
su - postgres -c "createuser -s koozic"

# Give to koozic user the right to write in app volume
chown -R koozic /home/koozic/.local

# Initialize db (odoo automatically detects if db is already initialized)
echo "KooZic init process starting"
su - koozic -c "/usr/local/koozic/odoo-bin \
                -d koozic-v3 \
                --db_port=54321 \
                -u oomusic,oovideo \
                --without-demo=all \
                --stop-after-init \
		--logfile /home/koozic/.local/koozic.log \
                --log-level=warn"
echo "KooZic init process complete"

# Start koozic
echo "Starting KooZic"
echo "The log is available by connecting to the container:"
echo "    docker exec -ti <CONTAINER ID> /bin/bash"
echo "    tail -f /home/koozic/.local/koozic.log"
su - koozic -c "/usr/local/koozic/odoo-bin \
                --workers=4 \
                --limit-time-cpu=1800 \
                --limit-time-real=3600 \
                -d koozic-v3 \
                --db-filter=koozic-v3 \
                --db_port=54321 \
                --without-demo=all \
                --no-database-list \
		--logfile /home/koozic/.local/koozic.log \
                --log-level=warn"
