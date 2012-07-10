#!/bin/sh -e
VER=1.4.3
PNAME=libX11
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/lib/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/ --disable-loadable-xcursor || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
