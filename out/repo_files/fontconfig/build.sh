#!/bin/sh -e
VER=2.9.0
test -e fontconfig-$VER.tar.gz || wget http://www.freedesktop.org/software/fontconfig/release/fontconfig-$VER.tar.gz
rm -rf fontconfig-$VER;tar -xf fontconfig-$VER.tar.gz
cd fontconfig-$VER

./configure --prefix=/
make LDFLAGS="$LDFLAGS -Wl,-rpath-link=/lib"
make DESTDIR=$1 install

cd ..
rm -rf fontconfig-$VER
