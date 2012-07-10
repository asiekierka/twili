#!/bin/sh -e
VER=0.8.15
test -e irssi-$VER.tar.bz2 || wget http://irssi.org/files/irssi-$VER.tar.bz2
rm -rf irssi-$VER;tar -xf irssi-$VER.tar.bz2
cd irssi-$VER

# TODO: Fix SSL
CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ --disable-ssl
make
make DESTDIR=$1 install

cd ..
rm -rf irssi-$VER
