#!/bin/sh -e
VER=0.25
test -e pkg-config-$VER.tar.gz || wget http://pkgconfig.freedesktop.org/releases/pkg-config-$VER.tar.gz
rm -rf pkg-config-$VER;tar -xf pkg-config-$VER.tar.gz
cd pkg-config-$VER

./configure --prefix=/
make
make DESTDIR=$1 install
cd ..
rm -rf pkg-config-$VER
