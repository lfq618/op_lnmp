#!/bin/bash
# author lilei
# 安装php的phalcon扩展

source ./config.sh

cd $PKG_PATH
git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
./install
