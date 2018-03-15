#!/bin/sh
cd $(dirname $0)
docker exec -it $(docker ps -aqf "name=kongTest_1") /bin/bash