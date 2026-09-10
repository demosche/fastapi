#!/bin/bash

set -e

DOMAIN=$(grep '^DOMAIN=' .env | cut -d '=' -f2)

if [ -z "$DOMAIN" ]; then
    echo "DOMAIN is not in .env"
    exit 1
fi

echo "Domain: $DOMAIN"

sudo docker compose run --rm -p 80:80 certbot certonly --test-cert --standalone --preferred-challenges http --agree-tos --register-unsafely-without-email --cert-name "$DOMAIN" --config-dir /etc/letsencrypt --work-dir /var/lib/letsencrypt --logs-dir /var/lib/letsencrypt/log -d "$DOMAIN" -n