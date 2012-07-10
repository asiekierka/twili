#!/bin/sh -e
VER=0.20
PNAME=ncmpc
EXT=tar.bz2
test -e $PNAME-$VER.$EXT || wget http://downloads.sourceforge.net/musicpd/$PNAME-$VER.$EXT
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.$EXT
cd $PNAME-$VER

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
