#!/bin/sh -e
VER=1.0.6
PNAME=twm
test -e $PNAME-$VER.tar.bz2 || wget http://xorg.freedesktop.org/releases/individual/app/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

CFLAGS=-D_GNU_SOURCE ./configure --prefix=/ || exit 1
make LIBS="-lX11 -lxcb -lXau -lXdmcp" || exit 1
mkdir -p $1/bin/
cp src/twm $1/bin/

cd ..
rm -rf $PNAME-$VER
