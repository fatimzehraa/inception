#!/bin/bash

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /bin/wp

wp core download --path="/var/www/html" --allow-root

if wp --allow-root db check; then
	exit 1
fi

wp config create --skip-check --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --dbprefix="$WP_PREFIX" --path="/var/www/html" --allow-root 

echo "CREATE DATABASE $MYSQL_DATABASE ;"

wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root 

sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

chmod -R 777 /var/www/html

service php7.3-fpm start

service php7.3-fpm stop

php-fpm7.3 -F
