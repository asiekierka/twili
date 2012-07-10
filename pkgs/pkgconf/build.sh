#!/bin/sh -e
VER=0.8
test -e pkgconf-$VER.tar.bz2 || wget http://nenolod.net/~nenolod/distfiles/pkgconf-0.8.tar.bz2
rm -rf pkgconf-$VER;tar -xf pkgconf-$VER.tar.bz2
cd pkgconf-$VER

CFLAGS="-D_GNU_SOURCE -D_BSD_SOURCE" ./configure -C --prefix=/
make
make DESTDIR=$1 -j1 install
cd ..
rm -rf pkgconf-$VER
