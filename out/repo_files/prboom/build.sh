#!/bin/sh -e
VER=2.5.0
test -e prboom-$VER.tar.gz || wget http://downloads.sourceforge.net/project/prboom/prboom%20stable/$VER/prboom-$VER.tar.gz
rm -rf prboom-$VER;tar -xf prboom-$VER.tar.gz
cd prboom-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ --disable-gl
sed -i "s|$(prefix)/games|$(prefix)/bin|" src/Makefile
make
make DESTDIR=$1 install

cd ..
rm -rf prboom-$VER
