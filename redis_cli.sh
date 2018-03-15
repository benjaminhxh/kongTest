#!/bin/sh
cd $(dirname $0)
docker exec -it $(docker ps -aqf "name=redis_1") redis-cli