#!/bin/bash

service mysql start

sleep 5

ls -la /var/run/mysqld/

chmod 777 /var/run/mysqld/mysqld.sock

sed -i "s/"127.0.0.1"/"0.0.0.0"/g" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "CREATE DATABASE $MYSQL_DATABASE ;"
mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE ;"

echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mysql -u root -e "FLUSH PRIVILEGES ;"

echo "grant all privileges on $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' ;"
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;"
echo "FLUSH PRIVILEGES ;"
mysql -u root -e "FLUSH PRIVILEGES ;"

mysqladmin -u root -p$MYSQL_PASSWORD shutdown

mysqld
