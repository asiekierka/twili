#!/bin/sh -e
VER=1.3.2
test -e fluxbox-$VER.tar.gz || wget http://downloads.sourceforge.net/project/fluxbox/fluxbox/$VER/fluxbox-$VER.tar.gz
rm -rf fluxbox-$VER;tar -xf fluxbox-$VER.tar.gz
cd fluxbox-$VER

sed -i 's/-ldnet//' configure
CXXFLAGS="$CXXFLAGS -Wl,-rpath-link=/lib -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf fluxbox-$VER
