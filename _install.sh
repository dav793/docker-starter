#!/bin/bash
cd "$(dirname "$0")"    # use script's location as working directory

source .env
ENV_USER=$(whoami) docker compose --env-file .env -f docker/docker-compose.install.yml up
