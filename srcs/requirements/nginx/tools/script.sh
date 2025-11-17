#!/bin/sh

if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ]; then
  openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx_selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=BE/L=BX/O=42Belgium/OU=student/CN=ade-beco.42.fr"
fi

nginx -g 'daemon off;'