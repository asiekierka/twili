#!/bin/sh -e
VER=1.2.0
test -e yasm-$VER.tar.gz || wget http://www.tortall.net/projects/yasm/releases/yasm-$VER.tar.gz
rm -rf yasm-$VER;tar -xf yasm-$VER.tar.gz
cd yasm-$VER

./configure --prefix=/ 
make
make DESTDIR=$1 -j1 install

cd ..
rm -rf yasm-$VER
