#!/bin/sh -e
VER=1.4.30
test -e lighttpd-$VER.tar.bz2 || wget http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-$VER.tar.bz2
rm -rf lighttpd-$VER;tar -xf lighttpd-$VER.tar.bz2
cd lighttpd-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install
mkdir -p $1/var/www
mkdir -p $1/etc
cp ../lighttpd.conf $1/etc

mkdir -p $1/etc/service/
cp -R ../service/lighttpd $1/etc/service/

cd ..
rm -rf lighttpd-$VER
