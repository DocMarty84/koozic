#!/bin/bash

# Wait for Postgres to be up
sleep 5

# Give to koozic user the right to write in app volume
chown -R koozic /home/koozic/.local

# Initialize db (odoo automatically detects if db is already initialized)
echo "KooZic init process starting"
su - koozic -c "/usr/local/koozic/odoo-bin \
                -d koozic-v2 \
                --db_host=db \
                --db_port=5432 \
                --db_user=koozic \
                --db_password=koozic \
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
                -d koozic-v2 \
                --db-filter=koozic-v2 \
                --db_host=db \
                --db_port=5432 \
                --db_user=koozic \
                --db_password=koozic \
                --without-demo=all \
                --no-database-list \
		--logfile /home/koozic/.local/koozic.log \
                --log-level=warn"
