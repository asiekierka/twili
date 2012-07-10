#!/bin/sh -e
VER=0.3
PNAME=libpthread-stubs
test -e $PNAME-$VER.tar.bz2 || wget http://xcb.freedesktop.org/dist/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/ || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
