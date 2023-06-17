#!/bin/bash

#service mysql start

ls -la /var/run/mysqld/

#chmod 777 /var/run/mysqld/mysqld.sock

sed -i "s/'#bind-address            = 127.0.0.1'/'bind-address            = 0.0.0.0'/g" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "CREATE DATABASE $MYSQL_DATABASE ;"
mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE ;"

echo "CREATE USER '$MYSQL_USER'@'mariadb' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mysql -u root -e "CREATE USER '$MYSQL_USER'@'mariadb' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mysql -u root -e "FLUSH PRIVILEGES ;"

echo "grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'mariadb' ;"
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'mariadb' ;"
mysql -u root -e "FLUSH PRIVILEGES ;"

#service mysql stop
mysqladmin -u root -p$MYSQL_PASSWORD shutdown


mysqld
