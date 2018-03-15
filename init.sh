#!/bin/sh

cd $(dirname $0)

red='\033[31m'
yellow='\033[34m'
green='\033[32m'
NC='\033[0m'

pip install oss2


echo "${yellow}1. 准备创建必要的目录${NC}"
# create dirs
mkdir -p ./data/mysql
mkdir -p ./data/mongo
mkdir -p ./data/redis
mkdir -p ./data/elastic
chmod -R 777 ./data/elastic
mkdir -p ./logs/app
mkdir -p ./logs/mysql
mkdir -p ./logs/mongo
mkdir -p ./logs/redis
mkdir -p ./logs/elastic
chmod -R 777 ./logs/mysql
chmod -R 777 ./logs/mongo
chmod -R 777 ./logs/redis
chmod -R 777 ./logs/elastic

echo "${yellow}目录创建完毕${NC}"



has_docker=`command -v docker`
# install Docker
if [ ! $has_docker ];then
    echo "${yellow}2. 安装docker${NC}"
    curl -sSL https://get.daocloud.io/docker | sh
    systemctl enable docker
    cp -n /lib/systemd/system/docker.service /etc/systemd/system/docker.service
    sed -i "s|ExecStart=/usr/bin/dockerd|ExecStart=/usr/bin/dockerd --registry-mirror=https://3wfyhd38.mirror.aliyuncs.com|g" /etc/systemd/system/docker.service
    systemctl daemon-reload
    echo "${yellow}启动docker${NC}"
    service docker restart
    echo "${yellow}docker启动成功${NC}"
else
    echo "${yellow}2. docker已经安装${NC}"
fi

has_docker_compose=`command -v docker-compose`
if [ ! $has_docker_compose ];then
    echo "${yellow}3. 准备安装docker-compose${NC}"
    # install docker-compose
    curl -L http://39.108.78.208:5100/docker-compose > /tmp/docker-compose
    mv /tmp/docker-compose /usr/local/bin/docker-compose
    chmod a+x /usr/local/bin/docker-compose
    docker-compose version
    echo "${yellow}docker-compose安装成功${NC}"
else
    echo "${yellow}3. docker-compose已经安装${NC}"
fi


echo "${yellow}4. docker swarm init${NC}"
docker swarm init

echo "${yellow}5. 设置环境变量${NC}"
# setup environments

# for elastic search
echo "vm.max_map_count=262144" >>/etc/sysctl.conf
sysctl -w vm.max_map_count=262144

# sh tools/convert_config_temp.sh

echo "${yellow}6. 设置备份脚本${NC}"
sh tools/init_backup.sh

echo "${yellow}7. 安装完毕${NC}"
