FROM debian:trixie

RUN apt -y update && apt -y install mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqlq \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/script.sh /usr/local/bin/mariadb.sh
COPY ./conf/wordpress.sql /usr/local/bin/wordpress.sql
RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]
