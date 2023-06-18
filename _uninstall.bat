:: @ECHO OFF

call .env.bat
docker compose -f docker/docker-compose.yml down
docker image rm %GAME_CLIENT_CONTAINER_NAME%
docker image rm %GAME_SERVER_CONTAINER_NAME%
