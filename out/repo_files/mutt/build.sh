#!/bin/sh -e
VER=1.4.2.3
test -e mutt-$VER.tar.gz || wget ftp://ftp.mutt.org/mutt/mutt-$VER.tar.gz
rm -rf mutt-$VER;tar -xf mutt-$VER.tar.gz
cd mutt-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install -j1

cd ..
rm -rf mutt-$VER
