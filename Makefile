deploy:
	sudo docker compose up -d --build fastapi && \
	sudo docker compose stop nginx && \
	sudo docker compose run --rm -p 80:80 certbot certonly \
  		--standalone \
  		--preferred-challenges http \
  		--agree-tos \
  		--register-unsafely-without-email \
  		--cert-name "$(grep '^DOMAIN=' .env | cut -d '=' -f2)" \
  		--config-dir /etc/letsencrypt \
  		--work-dir /var/lib/letsencrypt \
  		--logs-dir /var/lib/letsencrypt/log \
  		-d "$(grep '^DOMAIN=' .env | cut -d '=' -f2)" \
  		-n && \
	sudo docker compose up -d nginx