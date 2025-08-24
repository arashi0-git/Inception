#!/bin/sh
cd /var/www/html

# Wait for MariaDB to be ready
until mysql -h mariadb -u wpuser -pwppass --skip-ssl -e "SELECT 1" >/dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 3
done

wp config create --dbname="wordpress" --dbuser="wpuser" --dbpass="wppass" --dbhost="mariadb:3306" --allow-root

wp core install --url="https://aryamamo.42.fr" --title="Inception Site" \
--admin_user="siteowner" --admin_password="ownerpass" \
--admin_email="owner@example.com" --allow-root

wp user create editor editor@example.com --role=editor \
--user_pass="editorpass" --allow-root

exec "$@"
