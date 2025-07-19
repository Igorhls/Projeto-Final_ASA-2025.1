#!/bin/bash

docker-compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot --email seu-email@dominio.com --agree-tos --no-eff-email -d portal.asa.br -d webmail.asa.br -d mail.asa.br

docker-compose run --rm certbot renew --force-renewal

docker-compose run --rm --entrypoint "/bin/sh -c" certbot "cat /etc/letsencrypt/live/portal.asa.br/fullchain.pem /etc/letsencrypt/live/portal.asa.br/privkey.pem > /etc/letsencrypt/live/portal.asa.br/combined.pem"

docker-compose run --rm --entrypoint "/bin/sh -c" certbot "cat /etc/letsencrypt/live/webmail.asa.br/fullchain.pem /etc/letsencrypt/live/webmail.asa.br/privkey.pem > /etc/letsencrypt/live/webmail.asa.br/combined.pem"

docker-compose run --rm --entrypoint "/bin/sh -c" certbot "cat /etc/letsencrypt/live/mail.asa.br/fullchain.pem /etc/letsencrypt/live/mail.asa.br/privkey.pem > /etc/letsencrypt/live/mail.asa.br/combined.pem"

cp /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/live/portal.asa.br/combined.pem /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/asa.br.pem
cp /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/live/portal.asa.br/privkey.pem /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/asa.br.key
cp /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/live/portal.asa.br/fullchain.pem /home/ubuntu/isp-project/isp-project/haproxy/certbot/conf/asa.br.crt

chmod +x /home/ubuntu/isp-project/isp-project/haproxy/generate_certs.sh


