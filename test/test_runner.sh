#!/bin/bash

#!/bin/bash

# Define the names of your Docker containers
container_names=("proxy" "backend" "database")

# Function to check if a container is running
container_is_running() {
  local container_name="$1"
  docker ps --format '{{.Names}}' | grep -q "^$container_name$"
}

# Function to check if a container is built
container_is_built() {
  local image_name="sherifkunch/go-app"
  docker images --format '{{.Repository}}' | grep -q "^$image_name$"
}

# Iterate through the container names and check if they are built and running
for container_name in "${container_names[@]}"; do
  if container_is_running "$container_name"; then
    echo "Container $container_name is running."
  else
    echo "Container $container_name is NOT running."
    exit 1
  fi

  if container_is_built "$container_name"; then
    echo "Image for $container_name is built."
  else
    echo "Image for $container_name is NOT built."
    exit 1
  fi
done

# export BACKEND=`docker-compose ps -q backend`

# docker exec ${BACKEND} ls | grep "main.go"

# # Perform a health check by sending a GET request to a known endpoint
# curl -v -sSf -x 127.0.0.1:80 http://backend:8000 | grep "Blog post #0"
# if [[ $? != 0 ]]; then
#   echo "Proxy is not healthy"
#   exit 1
# fi

# we can think of many other tests here, this one above is just an example
# moreover, there are helpful tools which can be used to create such tests, but for simplicity I added just a simple one