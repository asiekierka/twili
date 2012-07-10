#!/bin/sh -e
VER=2.0.18-stable
test -e libevent-$VER.tar.gz || wget --no-check-certificate https://github.com/downloads/libevent/libevent/libevent-$VER.tar.gz
rm -rf libevent-$VER;tar -xf libevent-$VER.tar.gz
cd libevent-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf libevent-$VER
