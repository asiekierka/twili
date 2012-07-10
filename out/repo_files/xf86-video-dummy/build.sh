#!/bin/sh -e
VER=0.3.5
PNAME=xf86-video-dummy
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/driver/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

CFLAGS="-fPIC" LDFLAGS="-Wl,-rpath-link=/lib" ./configure --prefix=/ --disable-dga
make || exit 1
make DESTDIR="$1" install || exit 1

cd ..
rm -rf $PNAME-$VER
