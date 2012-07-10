#!/bin/sh -e
VER=4.2.1
test -e sed-$VER.tar.bz2 || wget http://ftp.gnu.org/pub/gnu/sed/sed-$VER.tar.bz2
rm -rf sed-$VER;tar -xf sed-$VER.tar.bz2
cd sed-$VER

./configure --prefix=/ --disable-nls
make CFLAGS="$CFLAGS"
make DESTDIR=$1 install

cd ..
rm -rf sed-$VER
