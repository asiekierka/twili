#!/bin/sh -e
VER=1.0.5
PNAME=xclock
test -e $PNAME-$VER.tar.bz2 || wget http://xorg.freedesktop.org/releases/individual/app/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/ || exit 1
make LIBS="-lfontconfig -lexpat -lfreetype -lz -lbz2 -lXrender -lXext -lXpm -lX11 -lxcb -lXau -lSM -lICE -lXdmcp" || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
