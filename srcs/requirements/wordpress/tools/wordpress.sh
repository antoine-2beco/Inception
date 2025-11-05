#!/bin/bash

if [ -f ./wp-config.php ]
then
  echo "wordpress already downloaded"
else

#  wp core download --allow-root

# # This will generate the WordPress configuration file, and the options ( --dbname, --dbuser, --dbpass, --dbhost )
# # are just placeholders that will get replaced once the script runs
# wp config create --allow-root --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PWD} --dbhost=${WP_HOST}

# # This will then install WordPress, and again, all the options are just placeholders that will get replaced
# wp core install --allow-root --url=${DOMAIN} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

# # This create a new WordPress user, and sets its role to author ( --role=author )
# wp user create "${WP_USER}" "${WP_EMAIL}" --user_pass="${WP_PASSWORD}" --role=author

wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
mv wordpress/* .
rm -rf latest.tar.gz
rm -rf wordpress

sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
sed -i "s/password_here/$DB_PWD/g" wp-config-sample.php
sed -i "s/localhost/$DB_HOST/g" wp-config-sample.php
sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
cp wp-config-sample.php wp-config.php

fi

exec "$@"
