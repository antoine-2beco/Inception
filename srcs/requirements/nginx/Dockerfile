FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

COPY ./tools/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

ENTRYPOINT ["/script.sh"]