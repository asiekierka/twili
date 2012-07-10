#!/bin/sh -e
VER=1.6
PNAME=xcb-proto
test -e $PNAME-$VER.tar.bz2 || wget http://xcb.freedesktop.org/dist/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
