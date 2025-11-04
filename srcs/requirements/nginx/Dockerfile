FROM debian:trixie

RUN apt -y update && apt install -y nginx && apt install -y openssl

RUN mkdir /etc/nginx/ssl
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
 -keyout $KEY_CERTS \
 -out $CERTS \
 -subj "/C=BE/L=BX/O=42Belgium/OU=student/CN=ade-beco.42.fr"

COPY ./conf/default /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE 443

# run nginx in front mode, not in background, really important for Docker who check if nginx runs
RUN ["nginx", "-g", "daemon off;"]
