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
    echo "Перезапуск Nginx"
    docker compose restart nginx
else
    echo "     ОШИБКА"
    exit $RESULT
fi