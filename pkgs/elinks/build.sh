#!/bin/sh -e
VER=0.11.7
test -e elinks-$VER.tar.bz2 || wget http://elinks.or.cz/download/elinks-0.11.7.tar.bz2
rm -rf elinks-$VER;tar -xf elinks-$VER.tar.bz2
cd elinks-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install
cd ..
rm -rf elinks-$VER
