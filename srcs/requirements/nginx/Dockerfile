FROM alpine:3.22

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir -p /etc/ssl/private /etc/ssl/certs

# create de self-signed ssl certificate
# -x509 : generate a auto signed certificate
# -nodes : do not encrypt the password
# -days 365 : valid for 1 year
# -newkey rsa:2048 : create a rsa key
# -keyout : location to put the key
# -out : location to put the certificate
# -subj : informations about the certificate
RUN openssl req -x509 -nodes -days 365 \
 -newkey rsa:2048 \
 -keyout /etc/ssl/private/nginx_selfsigned.key \
 -out /etc/ssl/certs/nginx-selfsigned.crt \
 -subj "/C=BE/L=BX/O=42Belgium/OU=student/CN=ade-beco.42.fr"

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

# run nginx in front mode, not in background, really important for Docker who check if nginx runs
RUN ["nginx", "-g", "daemon off;"]
