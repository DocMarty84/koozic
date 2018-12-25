#!/bin/bash

set -e

service postgresql restart
sleep 5

case "$1" in
    -- | odoo)
        /usr/local/koozic/odoo-bin \
            --workers=4 \
            --limit-time-cpu=1800 \
            --limit-time-real=3600 \
            --db_port=54321 \
            --without-demo=all \
            --no-database-list \
            --log-level=warn
        ;;
    *)
        exec "$@"
esac

exit 1
