#!/bin/bash

# Build Docker containers using Docker Compose
echo "Building Docker containers..."
docker-compose build --pull --no-cache

sleep 5 

docker-compose up -d 

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "Docker containers built successfully."

  sleep 10 

  # Run the test runner script
  echo "Running tests..."
  ./test/test_runner.sh

  # Check the exit code of the test runner script
  if [ $? -eq 0 ]; then
    echo "Tests passed. Everything is working fine."
  else
    echo "Tests failed. There might be an issue."
    exit 1
  fi
else
  echo "Failed to start Docker containers."
  exit 2
fi
