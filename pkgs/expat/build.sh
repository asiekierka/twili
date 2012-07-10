#!/bin/sh -e
VER=2.1.0
test -e expat-$VER.tar.gz || wget http://downloads.sourceforge.net/project/expat/expat/$VER/expat-$VER.tar.gz
rm -rf expat-$VER;tar -xf expat-$VER.tar.gz
cd expat-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf expat-$VER
