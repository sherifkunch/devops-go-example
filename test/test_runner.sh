#!/bin/bash

wkdir=$(dirname $0)

OSHT_JUNIT=1
OSHT_VERBOSE=1


export BACKEND=`docker-compose ps -q backend`
if [ ! -d ${wkdir}/../target ];then
    mkdir ${wkdir}/../target
fi

OSHT_JUNIT_OUTPUT=${wkdir}/../target/docker-backend-test.xml

cd test
. osht.sh

PLAN 2

RUNS docker exec ${BACKEND} ls
GREP "main.go"
