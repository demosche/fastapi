To clone this repo
```
git clone https://github.com/demosche/fastapi.git
```
To build
```
docker compose -d --build
```
To run
```
docker compose up
```
далее использовать для получения сертификат через certbot, сначала сделать скрипт исполняемым
```
chmod +x .dnschallenge.sh
```
и после этого можно запускать скрипт
```
./.dnschallenge.sh
```