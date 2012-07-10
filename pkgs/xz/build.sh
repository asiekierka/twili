#!/bin/sh -e
VER=5.0.3
test -e xz-$VER.tar.bz2 || wget http://tukaani.org/xz/xz-$VER.tar.bz2
rm -rf xz-$VER;tar -xf xz-$VER.tar.bz2
cd xz-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf xz-$VER
