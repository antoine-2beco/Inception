FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

COPY ./tools/script.sh ./script.sh

ENTRYPOINT ["sh", "./script.sh"]

EXPOSE 3306
