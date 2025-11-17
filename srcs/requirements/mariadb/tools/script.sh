#!/bin/sh

sed -i 's/bind-address/#bind-address/' /etc/my.cnf.d/mariadb-server.cnf

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld
    chmod 750 /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --datadir=/var/lib/mysql --user=mysql > /dev/null
    /usr/bin/mysqld --user=mysql --skip-networking &
    until mysqladmin ping --silent; do
    printf '.'
    sleep 1
    done
    mariadb -u root -e "DROP DATABASE test;"
    mariadb -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');"
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    mariadb -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PWD}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
    mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown
fi

sed -i 's/bind-address/#bind-address/' /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
chmod -R 777 /var/lib/mysql

exec /usr/bin/mysqld --user=mysql