#!/bin/sh
set -e
cd /var/www/html

DB_HOST="${WORDPRESS_DB_HOST:-mariadb}"
DB_NAME="${WORDPRESS_DB_NAME:-wordpress}"
DB_USER="${WORDPRESS_DB_USER:-wpuser}"
DB_PASS="${WORDPRESS_DB_PASSWORD:-wppass}"

until mysql -h "${DB_HOST%:*}" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1" >/dev/null 2>&1; do
  echo "Waiting for MariaDB at $DB_HOST..."
  sleep 3
done

if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" \
    --skip-check --allow-root
fi

SITE_URL="${WP_SITE_URL:-https://aryamamo.42.fr}"
if ! wp core is-installed --allow-root; then
  wp core install \
    --url="$SITE_URL" --title="Inception Site" \
    --admin_user="${WP_ADMIN_USER:-siteowner}" \
    --admin_password="${WP_ADMIN_PASSWORD:-ownerpass}" \
    --admin_email="${WP_ADMIN_EMAIL:-owner@example.com}" \
    --skip-email --allow-root

  if ! wp user get editor --field=ID --allow-root >/dev/null 2>&1; then
    wp user create editor editor@example.com --role=editor --user_pass="editorpass" --allow-root
  fi
fi

chown -R www-data:www-data /var/www/html

exec "$@"
