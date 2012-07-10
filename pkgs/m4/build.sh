#!/bin/sh -e
VER=1.4.16
test -e m4-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/m4/m4-$VER.tar.bz2
rm -rf m4-$VER;tar -xf m4-$VER.tar.bz2
cd m4-$VER

patch -p1 <../m4-hack-gnulib.patch
CC="$CC -static" ./configure --prefix=/ 

make
make DESTDIR=$1 install

cd ..
rm -rf m4-$VER
