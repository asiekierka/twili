#!/bin/sh -e
VER=1.2.7
test -e zlib-$VER.tar.gz || wget http://zlib.net/zlib-$VER.tar.gz
rm -rf zlib-$VER;tar -xf zlib-$VER.tar.gz
cd zlib-$VER

./configure --prefix=/
make
make DESTDIR=$1 install
cd ..
rm -rf zlib-$VER
