#!/bin/sh

docker-compose rm -f
docker-compose pull
docker-compose up --remove-orphans --force-recreate --timeout 5
docker-compose stop -t 5
