#!/bin/bash

#apt-get install -y php-fpm php-mysql # mariadb-client sendmail service

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#wget https://wordpress.org/latest.tar.gz
#tar -xvf latest.tar.gz
#cd wordpress
chmod +x wp-cli.phar
mv wp-cli.phar /bin/wp

#service mysql start

#mkdir -p /var/www/html

wp core download --path="/var/www/html" --allow-root

echo "hell";
rm -rf /var/www/html/wp-config.php;
wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --path="/var/www/html" --skip-check --allow-root

echo "hell fire";

wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root 

sed -i -e "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g" /etc/php/7.4/fpm/pool.d/www.conf

pwd
ls /var/www/html

#service php-fpm stop

service php7.4-fpm start

service php7.4-fpm stop

php-fpm7.4 -F
