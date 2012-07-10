#!/bin/sh -e
VER=1.3.0
PNAME=xinit
test -e $PNAME-$VER.tar.bz2 || wget http://xorg.freedesktop.org/releases/individual/app/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

CFLAGS=-D_GNU_SOURCE ./configure --prefix=/ || exit 1
make LIBS="-lX11 -lxcb -lXau -lXdmcp" || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
