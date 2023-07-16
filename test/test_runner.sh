#!/bin/bash

export BACKEND=`docker-compose ps -q backend`

docker exec ${BACKEND} ls | grep "main.go"

# Perform a health check by sending a GET request to a known endpoint
curl -sSf -x localhost:80 http://backend:8000 | grep "Blog post #0"
if [[ $? != 0 ]]; then
  echo "Proxy is not healthy"
  exit 1
fi