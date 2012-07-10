#!/bin/sh -e
VER=2.6.1
test -e patch-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/patch/patch-$VER.tar.bz2
rm -rf patch-$VER;tar -xf patch-$VER.tar.bz2
cd patch-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf patch-$VER
