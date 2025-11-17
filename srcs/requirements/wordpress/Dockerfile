FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache php php-cli php-mysqli php-gd php-mbstring php-xml php-phar php-fpm php-redis php-ctype wget mariadb-client envsubst

RUN adduser -S wordpress-fpm && addgroup -S wordpress-fpm 

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output-document=/usr/local/bin/wp && chmod -R +x /usr/local/bin/wp

RUN mkdir -p /var/www/html && chmod 755 /var/www/html

COPY ./tools/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./tools/script.sh ./

COPY ./tools/wp-config.php ./

ENTRYPOINT [ "sh", "./script.sh" ]

EXPOSE 9000
