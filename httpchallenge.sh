#!/bin/bash

echo "========================================"
echo "          CERTBOT SSL CERTIFICATE"
echo "========================================"
echo ""

if [ ! -f .env ]; then
    echo ".env not found"
    exit 1
fi

export $(grep -v '^#' .env | xargs)

if [ -z "$DOMAIN" ]; then
    echo "DOMAIN is not specified in .env"
    exit 1
fi

echo "Domain: $DOMAIN"
echo ""
docker compose stop nginx

docker compose run --rm certbot \
    certonly \
    --standalone \
    --preferred-challenges http \
    --agree-tos \
    --no-eff-email \
    --config-dir /etc/letsencrypt \
    --work-dir /var/lib/letsencrypt \
    --logs-dir /var/lib/letsencrypt/log \
    -d "$DOMAIN"
sudo docker compose run --rm certbot certonly --test-cert --standalone --preferred-challenges http --agree-tos --no-eff-email --config-dir /etc/letsencrypt --work-dir /var/lib/letsencrypt --logs-dir /var/lib/letsencrypt/log -d fassek.4100000.xyz

STATUS=$?

echo ""

if [ $STATUS -eq 0 ]; then
    echo "========================================"
    echo "     CERTIFICATE SUCCESSFULLY OBTAINED"
    echo "========================================"
    echo ""

    echo "Restarting Nginx..."

    docker compose restart nginx

    STATUS=$?

docker compose start nginx

    if [ $STATUS -ne 0 ]; then
        echo "Failed to restart Nginx"
        exit $STATUS
    fi

    sleep 2

    docker inspect -f '{{.State.Running}}' nginx 2>/dev/null | grep -q true

    STATUS=$?

    if [ $STATUS -eq 0 ]; then
        echo "Nginx restarted successfully"
    else
        echo "Nginx is not running after restart"
        exit $STATUS
    fi

else
    echo "========================================"
    echo "     CERTIFICATE ERROR"
    echo "========================================"
    exit $STATUS
fi