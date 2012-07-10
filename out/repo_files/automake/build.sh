#!/bin/sh -e
VER=1.12.1
test -e automake-$VER.tar.gz || wget http://ftp.gnu.org/gnu/automake/automake-$VER.tar.gz
rm -rf automake-$VER;tar -xf automake-$VER.tar.gz
cd automake-$VER

./configure --prefix=/ 
make
make DESTDIR=$1 install

cd ..
rm -rf automake-$VER
