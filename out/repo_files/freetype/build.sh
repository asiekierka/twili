#!/bin/sh -e
VER=2.4.9
test -e freetype-$VER.tar.bz2 || wget http://mirror.lihnidos.org/GNU/savannah/freetype/freetype-$VER.tar.bz2
rm -rf freetype-$VER;tar -xf freetype-$VER.tar.bz2
cd freetype-$VER

./configure --prefix=/
make DESTDIR=$1 install

cd ..
rm -rf freetype-$VER
