#!/bin/sh -e
VER=1.3.0
test -e fltk-$VER-source.tar.gz || wget http://ftp.easysw.com/pub/fltk/$VER/fltk-$VER-source.tar.gz
rm -rf fltk-$VER;tar -xf fltk-$VER-source.tar.gz
cd fltk-$VER

CXXFLAGS="-D_BSD_SOURCE" LDFLAGS="-Wl,-rpath-link=/lib" ./configure --prefix=/ --disable-xdbe
make
make DESTDIR=$1 install

cd ..
rm -rf fltk-$VER
