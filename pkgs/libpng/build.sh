#!/bin/sh -e
VER=1.5.10
test -e libpng-$VER.tar.gz || wget http://download.sourceforge.net/libpng/libpng-$VER.tar.gz
rm -rf libpng-$VER;tar -xf libpng-$VER.tar.gz
cd libpng-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf libpng-$VER
