#!/bin/sh
# Modify. Important!
APP=lua
VER=5.2.1
test -e $APP-$VER.tar.gz || wget http://www.lua.org/ftp/$APP-$VER.tar.gz
rm -rf $APP-$VER;tar -xf $APP-$VER.tar.gz
cd $APP-$VER

make ansi
make -j1 install INSTALL_TOP=$1

cd ..
rm -rf $APP-$VER


