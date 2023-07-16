#!/bin/bash

wkdir=$(dirname $0)

OSHT_JUNIT=1

export BACKEND=`docker-compose ps -q backend`

. ${wkdir}/osht.sh

PLAN 1

# it should be possible to search the ldap tree with read only user
RUNS docker exec ${BACKEND} bash -c 'ls'
GREP "main.go"
