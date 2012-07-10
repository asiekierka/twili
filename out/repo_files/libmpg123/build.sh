#!/bin/sh -e
VER=1.13.8
test -e mpg123-$VER.tar.bz2 || wget http://www.mpg123.de/download/mpg123-$VER.tar.bz2
rm -rf mpg123-$VER;tar -xf mpg123-$VER.tar.bz2
cd mpg123-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf mpg123-$VER
