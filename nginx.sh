#!/bin/bash
# author lilei
# 安装nginx脚本

source ./config.sh

NGINX_VERSION='nginx-1.8.0'


#添加nginx账号
useradd -M -s /sbin/nologin  -g app nginx

cd $PKG_PATH
#下载nginx包
wget http://nginx.org/download/${NGINX_VERSION}.tar.gz
tar -zxf ${NGINX_VERSION}.tar.gz

#下载nginx扩展模块
wget https://github.com/simpl/ngx_devel_kit/archive/v0.2.19.tar.gz
tar -zxf v0.2.19.tar.gz

wget https://github.com/openresty/set-misc-nginx-module/archive/v0.28.tar.gz
tar -zxf v0.28.tar.gz

cd ${NGINX_VERSION}
./configure --user=nginx --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module --with-http_image_filter_module --with-http_sub_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6 --add-module=../ngx_devel_kit-0.2.19 --add-module=../set-misc-nginx-module-0.28
make && make install

#复制nginx.conf文件
cp ${CONFIG_PATH}/nginx.conf /usr/local/nginx/conf/

#创建vhosts目录
mkdir /usr/local/nginx/conf/vhosts

mkdir -p ${LOG_PATH}/nginx/
chmod -R 777 ${LOG_PATH}/nginx/
