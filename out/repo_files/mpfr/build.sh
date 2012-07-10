#!/bin/sh -e
VER=3.1.0
test -e mpfr-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/mpfr/mpfr-$VER.tar.bz2
rm -rf mpfr-$VER;tar -xf mpfr-$VER.tar.bz2
cd mpfr-$VER

CC="$CC -L$R/lib -I$R/include" ./configure --prefix=/


make
make DESTDIR=$1 install

cd ..
rm -rf mpfr-$VER
