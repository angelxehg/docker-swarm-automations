#!/bin/sh

. /home/automations/included-scripts/docker/use-proxy.sh

echo "Attempting to execute a docker command via docker proxy..."

use_docker_proxy docker-socket-proxy 2375
