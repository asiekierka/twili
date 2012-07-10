#!/bin/sh -e
VER=1.3.0
PNAME=libogg
EXT=tar.gz
test -e $PNAME-$VER.$EXT || wget http://downloads.xiph.org/releases/ogg/$PNAME-$VER.$EXT
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.$EXT
cd $PNAME-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
