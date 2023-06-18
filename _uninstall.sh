#!/bin/bash
cd "$(dirname "$0")"    # use script's location as working directory

source .env
docker compose -f docker/docker-compose.yml down
docker image rm ${GAME_CLIENT_CONTAINER_NAME}
docker image rm ${GAME_SERVER_CONTAINER_NAME}