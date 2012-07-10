#!/bin/sh -e
VER=8d
test -e jpegsrc.v$VER.tar.gz || wget http://www.ijg.org/files/jpegsrc.v$VER.tar.gz
rm -rf jpeg-$VER;tar -xf jpegsrc.v$VER.tar.gz
cd jpeg-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf jpeg-$VER
