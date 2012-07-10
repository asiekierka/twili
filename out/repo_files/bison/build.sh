#!/bin/sh -e
VER=2.4.3
test -e bison-$VER.tar.gz || wget http://ftp.gnu.org/gnu/bison/bison-$VER.tar.gz
rm -rf bison-$VER;tar -xf bison-$VER.tar.gz
cd bison-$VER

M4="/bin/m4" CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ --disable-nls
make
make DESTDIR=$1 install
cd ..
rm -rf bison-$VER
