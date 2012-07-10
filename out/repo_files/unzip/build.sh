#!/bin/sh -e
VER=60
test -e unzip$VER.tar.gz || wget http://downloads.sourceforge.net/infozip/unzip$VER.tar.gz
rm -rf unzip$VER;tar -xf unzip$VER.tar.gz
cd unzip$VER

make -f unix/Makefile generic LOCAL_UNZIP="-DDECLARE_TIMEZONE"
make -f unix/Makefile prefix=$1 install

cd ..
rm -rf unzip$VER
