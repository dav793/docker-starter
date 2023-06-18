:: @ECHO OFF

call .env.bat
set ENV_USER=%USERNAME%
docker compose --env-file .env -f docker/docker-compose.install.yml up
