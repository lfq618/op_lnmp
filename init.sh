#!/bin/bash
# author lilei
# 初始化脚本
source ./config.sh

#更新系统，防止漏洞入侵
yum upgrade

#安装相关依赖库
yum  install net-tools wget tar pcre pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers cmake make gd gd2 gd-devel gd2-devel bison perl-Module-Install.noarch vim readline-devel libxslt-devel imake lrzsz unzip git

#创建pkg目录，如果不存在的话
mkdir -p $PKG_PATH
#创建数据目录
mkdir -p $DATA_PATH

mkdir -p ${LOG_PATH}/nginx/
chmod -R 777 ${LOG_PATH}/nginx/

mkdir -p ${LOG_PATH}/php/
chmod -R 777 ${LOG_PATH}/php/

#添加app账号
useradd app
