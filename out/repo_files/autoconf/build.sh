#!/bin/sh -e
VER=2.69
test -e autoconf-$VER.tar.gz || wget http://ftp.gnu.org/gnu/autoconf/autoconf-$VER.tar.gz
rm -rf autoconf-$VER;tar -xf autoconf-$VER.tar.gz
cd autoconf-$VER

./configure --prefix=/ 
make
make DESTDIR=$1 install

cd ..
rm -rf autoconf-$VER
