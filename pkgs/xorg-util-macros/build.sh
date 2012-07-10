#!/bin/sh -e
VER=1.13.0
PNAME=util-macros
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/util/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

./configure --prefix=/
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
