#!/bin/sh
cd $(dirname $0)
docker exec -it $(docker ps -aqf "name=mysql_1") mysql -uroot -proot
