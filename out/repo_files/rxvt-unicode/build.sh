#!/bin/sh -e
VER=9.15
test -e rxvt-unicode-$VER.tar.bz2 || wget http://dist.schmorp.de/rxvt-unicode/rxvt-unicode-$VER.tar.bz2
rm -rf rxvt-unicode-$VER;tar -xf rxvt-unicode-$VER.tar.bz2
cd rxvt-unicode-$VER

./configure --disable-wtmp --disable-utmp --prefix=/ --enable-256-color --enable-xft --enable-font-styles
make LIBS="-lXau -lxcb"
make DESTDIR=$1 install

cd ..
rm -rf rxvt-unicode-$VER
