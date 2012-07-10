#!/bin/sh -e
VER=2.7.3
test -e Python-$VER.tar.bz2 || wget http://python.org/ftp/python/$VER/Python-$VER.tar.bz2
rm -rf Python-$VER;tar -xf Python-$VER.tar.bz2
cd Python-$VER

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf Python-$VER
