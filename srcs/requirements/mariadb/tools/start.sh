#!/bin/sh
set -e

DATA_DIR="/var/lib/mysql"

mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chmod 750 /var/lib/mysql

if [ ! -d "$DATA_DIR/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --ldata=$DATA_DIR

    echo "Running init.sql..."
    mysqld_safe --skip-networking &
    pid="$!"

    i=0
    until mariadb -uroot -e "SELECT 1" >/dev/null 2>&1; do
        i=$((i+1)); [ $i -gt 60 ] && echo "bootstrap timeout" && exit 1
        sleep 1
    done

    mariadb -uroot < /docker-entrypoint-initdb.d/init.sql

    kill -s TERM "$pid"
    wait "$pid"
fi

echo "Starting MariaDB server"
exec /usr/sbin/mariadbd --user=mysql --bind-address=0.0.0.0
