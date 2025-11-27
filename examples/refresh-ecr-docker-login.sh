#!/bin/sh

. /opt/automations/included-scripts/docker/use-proxy.sh

DOCKER_SOCKET_PROXY_HOST=docker-socket-proxy
DOCKER_SOCKET_PROXY_PORT=2375
AWS_REGION=us-east-1
AWS_ECR_REGISTRY=""# TODO: set this value

# Warning: This is meant to run with Docker Swarm

# Use Docker Socket Proxy
use_docker_proxy $DOCKER_SOCKET_PROXY_HOST $DOCKER_SOCKET_PROXY_PORT

# Login with AWS ECR (using EC2 IAM Profile)
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ECR_REGISTRY"

# Update service registry auth (does not re-create the service)
SERVICE_NAME="" # TODO: set this value

docker service update "$SERVICE_NAME" \
    --detach=false \
    --with-registry-auth
