#!/bin/bash
# author lilei
# 安装php脚本

source ./config.sh

PHP_VERSION='php-5.6.19'

#添加nginx账号
useradd -M -s /sbin/nologin  -g app php 

cd $PKG_PATH
#安装依赖库
wget http://www.ijg.org/files/jpegsrc.v9.tar.gz
tar -zxf  jpegsrc.v9.tar.gz
cd jpeg-9/
./configure --prefix=/usr/local/ --enable-shared --enable-static
make && make install

cd $PKG_PATH
wget http://prdownloads.sourceforge.net/libpng/libpng-1.6.2.tar.gz
tar -zxf libpng-1.6.2.tar.gz
cd libpng-1.6.2
./configure --prefix=/usr/local/
make && make install

cd $PKG_PATH
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.gz
tar -zxf freetype-2.4.12.tar.gz
cd freetype-2.4.12
./configure --prefix=/usr/local/
make && make install

cd $PKG_PATH
wget --content-disposition "http://downloads.sourceforge.net/mhash/mhash-0.9.9.9.tar.gz?big_mirror=0"
wget --content-disposition "http://downloads.sourceforge.net/mcrypt/libmcrypt-2.5.8.tar.gz?big_mirror=0"
wget --content-disposition "http://downloads.sourceforge.net/mcrypt/mcrypt-2.6.8.tar.gz?big_mirror=0"
tar -zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --prefix=/usr/local/
make && make install

cd libltdl/
./configure --prefix=/usr/local/ --enable-ltdl-install
make && make install

cd $PKG_PATH
tar -zxf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9/
./configure --prefix=/usr/local/
make && make install

cd $PKG_PATH
tar -zxf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8
export LDFLAGS="-L/usr/local/lib -L/usr/lib"
export CFLAGS="-I/usr/local/include -I/usr/include"
cat /usr/local/lib >> /etc/ld.so.conf
ldconfig
make && make install
./configure --prefix=/usr/local/ --with-libmcrypt-prefix=/usr/local
make && make install

#下载安装php
cd $PKG_PATH
wget  --content-disposition "http://cn2.php.net/get/${PHP_VERSION}.tar.gz/from/this/mirror"
tar -zxf ${PHP_VERSION}.tar.gz
cd ${PHP_VERSION}
export LIBS="-lm -ltermcap -lresolv"
export LD_LIBRARY_PATH="/usr/local/mysql/lib/:/lib/:/usr/lib/:/usr/local/lib:/lib64/:/usr/lib64/:/usr/local/lib64"
ln -s /usr/local/mysql/lib/libmysqlclient.so.18 /usr/lib
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config  --with-iconv-dir --with-freetype-dir=/usr/local/ --with-jpeg-dir=/usr/local/ --with-png-dir=/usr/local/ --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt=/usr/local/ --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-soap --with-pdo-mysql --enable-opcache  --with-pear --with-zlib --with-xsl --with-bz2 --with-gettext --with-readline --with-kerberos --disable-debug --enable-cli --enable-exif --enable-wddx --enable-zip --enable-calendar --enable-ftp --enable-dba --enable-sysvshm --enable-sysvmsg
make && make install

ln -s /usr/local/php/bin/php /usr/bin/
ln -s /usr/local/php/bin/phpize /usr/bin/
ln -s /usr/local/php/bin/php-config /usr/bin/

cp -f ${CONFIG_PATH}/php.ini ${CONFIG_PATH}/php-fpm.conf /usr/local/php/etc/

mkdir -p ${LOG_PATH}/php/
chmod -R 777 ${LOG_PATH}/php/
