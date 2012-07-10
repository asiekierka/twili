#!/bin/sh -e
VER=0.21.6
PNAME=pixman
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/lib/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

CFLAGS="-DPIXMAN_NO_TLS" ./configure --prefix=/ || exit 1
sed -i -e '/TOOLCHAIN_SUPPORTS_ATTRIBUTE_CONSTRUCTOR/d' -e '/TOOLCHAIN_SUPPORTS__THREAD/d' config.h
make || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
