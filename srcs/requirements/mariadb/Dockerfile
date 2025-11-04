FROM debian:trixie

RUN apt -y update && apt -y install mariadb-server

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

CMD [ "./script.sh" ]