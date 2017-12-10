#!/bin/bash
# author lilei
# 安装mysql

source ./config.sh

MYSQL_VERSION='mysql-5.6.24'
MYSQL_BIG_VERSION='MySQL-5.6'

#添加mysql账号
useradd -M -s /sbin/nologin  -g app mysql 

cd $PKG_PATH
#下载mysql包
wget http://dev.mysql.com/get/Downloads/${MYSQL_BIG_VERSION}/${MYSQL_VERSION}.tar.gz
tar -zxf ${MYSQL_VERSION}.tar.gz


cd ${MYSQL_VERSION}
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DWITH_SSL=system -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1  -DENABLED_LOCAL_INFILE=1
make && make install

mkdir -p /data/mysql/dbdata_3306
cd /usr/local/mysql/
./scripts/mysql_install_db --basedir=/usr/local/mysql --datadir=/data/mysql/dbdata_3306 --user=mysql

cp ${CONFIG_PATH}/my.cnf  /etc/

echo 'export PATH=/usr/local/mysql/bin:$PATH' >> /etc/profile
source /etc/profile
/usr/local/mysql/bin/mysqladmin -uroot password '123qwe' -S /data/mysql/dbdata_3306/mysql.sock

