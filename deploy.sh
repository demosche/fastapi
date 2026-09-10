#!/bin/bash

set -e

echo "building"

sudo docker compose up -d --build fastapi

echo "build"

echo "stopping nginx"

sudo docker compose stop nginx

echo "nginx is stop"

echo "running certbot"

./certbot.sh

echo "certbot is running"

echo "starting nginx"

sudo docker compose up -d nginx

echo "nginx is ready"

echo "done"