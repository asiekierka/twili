#!/bin/sh -e
VER=1.0.1
test -e htop-$VER.tar.bz2 || wget http://downloads.sourceforge.net/project/htop/htop/$VER/htop-$VER.tar.gz
rm -rf htop-$VER;tar -xf htop-$VER.tar.gz
cd htop-$VER

./configure --prefix=/ --disable-unicode
make
make DESTDIR=$1 install -j1

cd ..
rm -rf htop-$VER
