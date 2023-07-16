#!/bin/bash

export BACKEND=`docker-compose ps -q backend`

docker exec ${BACKEND} ls | grep "main.go"

