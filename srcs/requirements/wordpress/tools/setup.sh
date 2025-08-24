#!/bin/var
cd /var/www/html

wp config create --dbname="wordpress" --dbuer="wpuser" --dbpass="wppass" --dbhost="mariadb:3306"

wp core install --url="https://aryamamo.42.fr" --title="Inception Site"
--admin_user="siteowner" --admin_password="ownerpass"
--admin_email="owner@example.com"

wp user create editor editor@example.com --role=editor
--user_pass="editorpass"
