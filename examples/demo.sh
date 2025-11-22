#!/bin/sh

. /home/automations/included-scripts/docker/use-proxy.sh

echo "Attempting to execute a docker command via docker proxy..."

DOCKER_SOCKET_PROXY_HOST=docker-socket-proxy
DOCKER_SOCKET_PROXY_PORT=2375

use_docker_proxy $DOCKER_SOCKET_PROXY_HOST $DOCKER_SOCKET_PROXY_PORT

docker ps

echo "Attempting a forbidden command..."

docker service ls
