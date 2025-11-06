#!/bin/bash

# Initialiser la base de données si nécessaire
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initialisation de la base de données..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
	
	# Démarrer MySQL temporairement
	mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
	pid="$!"

	# Attendre que MySQL soit prêt
	for i in {30..0}; do
	    if echo 'SELECT 1' | mysql &> /dev/null; then
	        break
	    fi
	    sleep 1
	done

	# Créer la base et l'utilisateur
	mysql <<-EOSQL
	    CREATE DATABASE IF NOT EXISTS ${DB_NAME};
	    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
	    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
	    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
	    FLUSH PRIVILEGES;
		EOSQL

	# Arrêter MySQL temporaire
	kill -s TERM "$pid"
	wait "$pid"
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
