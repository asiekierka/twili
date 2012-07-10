#!/bin/sh -e
VER=2.3
test -e ne-$VER.tar.gz || wget http://ne.dsi.unimi.it/ne-$VER.tar.gz
rm -rf ne-$VER;tar -xf ne-$VER.tar.gz
cd ne-$VER

make PREFIX=/
make DESTDIR=$1 PREFIX=/ install
cd ..
rm -rf ne-$VER
