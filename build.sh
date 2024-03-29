#!/bin/bash

# Check if GITHUB_SHA is empty
if [ -z "$GITHUB_SHA" ]; then
  echo "GITHUB_SHA is empty. Generating a random string."
  export GITHUB_SHA=$(date '+%s')
else
  echo "GITHUB_SHA is not empty: $GITHUB_SHA"
fi

# Build Docker containers using Docker Compose

echo "Building Docker containers..."
docker-compose build

sleep 5 

docker-compose up -d 

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker containers built successfully."
   sleep 5

  echo "Running tests..."
  test/test_runner.sh
  
  # Check the exit code of the test runner script
  if [ $? -eq 0 ]; then
    echo "Tests passed. Everything is working fine."
    echo ""
  else
    echo "Tests failed. There might be an issue."
    exit 1
  fi
else 
  echo "Failed to start Docker containers."
  exit 2
fi

#docker login -u sherifkunch -p "${1}"

docker-compose push 

if [ $? -eq 0 ]; then
    echo "Pushed succesfully to dockerhub"
  else
    echo "Push failed."
    exit 1
  fi



