#!/bin/sh

# Wait for the mysqld_safe process to start
while [ 0$mysqld_process_pid -eq 0 ]
do
  mysqld_process_pid=$(echo "$(ps -C mysqld -o pid=)" | sed -e 's/^ *//g' -e 's/ *$//g')
  sleep 1
done

mysql -ve "CREATE DATABASE IF NOT EXISTS owncloud"
mysql -ve "CREATE USER 'owncloud'@'localhost' IDENTIFIED BY 'owncloud1234'"
mysql -ve "GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'localhost'"
mysql -ve "FLUSH PRIVILEGES"
mysqlshow db_name > /databases.txt
/etc/init.d/mysql restart
