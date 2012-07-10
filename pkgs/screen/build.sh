#!/bin/sh -e
VER=4.0.3
test -e screen-$VER.tar.gz || wget http://ftp.gnu.org/gnu/screen/screen-4.0.3.tar.gz
rm -rf screen-$VER;tar -xf screen-$VER.tar.gz
cd screen-$VER

patch -p1 <../screen.patch
CFLAGS="$CFLAGS -D_GNU_SOURCE -Dlinux" ./configure --prefix=/
cp ../screen-osdef.h ./osdef.h
make
make DESTDIR=$1 install

cd ..
rm -rf screen-$VER
