#!/bin/sh

use_docker_proxy() {
  local docker_socket_proxy_host="$1" # docker-socket-proxy
  local docker_socket_proxy_port="$2" # 2375

  # TODO: use nc

  echo "Docker available at tcp://$docker_socket_proxy_host:$docker_socket_proxy_port"

  # TODO: export DOCKER_HOST
}
