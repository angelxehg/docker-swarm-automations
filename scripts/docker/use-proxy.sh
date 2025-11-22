#!/bin/sh

use_docker_proxy() {
  local docker_socket_proxy_host="$1" # docker-socket-proxy
  local docker_socket_proxy_port="$2" # 2375
  local target_tcp_docker_host=tcp://"$docker_socket_proxy_host":"$docker_socket_proxy_port"

  if ! nc -z "$docker_socket_proxy_host" "$docker_socket_proxy_port"; then
    echo "Docker socket proxy not reachable at $target_tcp_docker_host"
    exit 1
  fi

  echo "Using Docker socket proxy at $target_tcp_docker_host"
}
