#!/bin/bash
# author lilei
# 安装php的redis扩展

source ./config.sh

cd $PKG_PATH
wget https://github.com/nicolasff/phpredis/archive/master.zip 
unzip master.zip
cd phpredis-master
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
