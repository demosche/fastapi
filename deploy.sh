#!/bin/bash

set -e

echo "Build"

sudo docker compose up -d --build fastapi

echo "Stop Nginx"

sudo docker compose stop nginx

echo "Run Certbot"

./certbot.sh

echo "Start Nginx"

sudo docker compose up -d

echo "Done"