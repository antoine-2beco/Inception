#!/bin/bash

sed -i 's/bind-address/#bind-address/' /etc/my.cnf.d/mariadb-server.cnf

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld
    chmod 750 /run/mysqld
fi

if [ ! -d "/var/lib/mysql/.initialized" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mariadb-install-db --datadir=/var/lib/mysql --user=mysql > /dev/null
    /usr/bin/mysqld --user=mysql --skip-networking &
    until mariadb-admin ping --silent; do
        printf '.'
        sleep 1
    done
    mariadb -u root -e "DROP DATABASE IF EXISTS test;"
    mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
	mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
    mariadb-admin -u root -p${MARIADB_ROOT_PASSWORD} shutdown

    touch /var/lib/mysql/.initialized
fi

sed -i 's/bind-address/#bind-address/' /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
chmod -R 777 /var/lib/mysql

exec /usr/bin/mysqld --user=mysql