#!/bin/sh
# author lilei
# 安装php的scws扩展

source ./config.sh

cd $PKG_PATH
wget -q -O - http://www.xunsearch.com/scws/down/scws-1.2.1.tar.bz2 | tar xjf -
cd scws-1.2.1 
./configure 
make install
cd phpext
/usr/local/php/bin/phpize
./configure --with-scws=/usr/local --with-php-config=/usr/local/php/bin/php-config
make && make install
