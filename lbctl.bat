@echo off
@set "COMPOSE_FILE=C:\Users\dopracau\Projects\lbctl\docker-compose.yml"
@docker-compose run --rm --name lbctl-liburutegia lbctl-liburutegia %*