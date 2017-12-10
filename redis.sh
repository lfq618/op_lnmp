#!/bin/bash
# author lilei
# 安装redis脚本

source ./config.sh

REDIS_VERSION='redis-3.0.1'

#添加redis账号
#useradd -M -s /sbin/nologin  -g app redis 

#下载安装php
cd $PKG_PATH
#wget http://download.redis.io/releases/${REDIS_VERSION}.tar.gz
tar xzf ${REDIS_VERSION}.tar.gz
cd ${REDIS_VERSION}
make && make install
cp ${CONFIG_PATH}/redis_6379.conf  /etc/redis_6379.conf
echo "vm.overcommit_memory=1"  >> /etc/sysctl.conf
