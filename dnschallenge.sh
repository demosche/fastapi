#!/bin/bash

if [ ! -f .env ]; then
    echo ".env не найден."
    exit 1
fi

export $(grep -v '^#' .env | xargs)

if [ -z "$DOMAIN" ]; then
    echo "Ошибка: DOMAIN не указан в .env."
    exit 1
fi

echo "$DOMAIN"

docker compose run --rm certbot \
    certonly \
    --manual \
    --preferred-challenges dns \
    --agree-tos \
    --no-eff-email \
    --config-dir /etc/letsencrypt \
    --work-dir /var/lib/letsencrypt \
    --logs-dir /var/lib/letsencrypt/log \
    -d "$DOMAIN"

RESULT=$?

echo ""

if [ $RESULT -eq 0 ]; then
    echo "УСПЕШНО"
    echo "checking nginx"

docker inspect -f '{{.State.Running}}' nginx 2>/dev/null | grep -q true

STATUS=$?

if [ $STATUS -eq 0 ]; then
    echo "Nginx is running"
    
    docker compose restart nginx

    STATUS=$?

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
    echo "Nginx is not running"
    exit $STATUS
fi
fi