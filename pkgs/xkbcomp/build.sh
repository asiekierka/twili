#!/bin/sh -e
VER=1.2.1
PNAME=xkbcomp
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/app/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/ || exit 1
make LIBS="-lX11 -lxcb -lXau -lXdmcp" || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
