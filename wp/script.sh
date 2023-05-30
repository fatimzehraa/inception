#!/bin/bash

apt-get install -y wget

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /bin/wp

mkdir -p /var/www/html


wp core download --path="/var/www/html" --allow-root

echo "hell";

wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --path="/var/www/html" --skip-check --allow-root

echo "hell fire";

wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root 


pwd
ls /var/www/html

service php7.3-fpm start

tail -f /dev/null
#php-fpm7.3 -F
