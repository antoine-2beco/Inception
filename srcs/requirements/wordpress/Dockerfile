FROM debian:trixie

RUN apt-get update && apt-get -y install wget curl bash php php-cgi php-mysql php-fpm \
	php-pdo php-gd php-cli php-mbstring && rm -rf /var/lib/apt/lists/*

# install wp-cli -> to manage wp by terminal
RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/www.conf /etc/php/8.4/fpm/pool.d/www.conf

RUN mkdir /run/php

COPY ./tools/script.sh /usr/local/bin
RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT [ "/usr/local/bin/script.sh" ]

WORKDIR /var/www/html/

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm8.4", "-F" ]
