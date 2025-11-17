#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp core download --allow-root --path="/var/www/html"
    until mysqladmin ping -h "${DB_HOST}" -u "${DB_USER}" -p"${MARIADB_WP_PASSW}" --silent; do
    printf '.'
    sleep 1
    done
    printf '\n'

    chown -R wordpress-fpm:wordpress-fpm /var/www/html
    wp core install --allow-root --url="${NGINX_HOST}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" --admin_email="${WP_ADMIN_EMAIL}" --path="/var/www/html" --skip-email
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --allow-root --role="author" --user_pass="${WP_USER_PWD}" --path="/var/www/html"
    chmod -R 777 /var/www/html
fi

exec php-fpm83 -F
