#!/bin/sh -e
VER=5.0.4
test -e gmp-$VER.tar.bz2 || wget http://ftpmirror.gnu.org/gmp/gmp-$VER.tar.bz2
rm -rf gmp-$VER;tar -xf gmp-$VER.tar.bz2
cd gmp-$VER

./configure --prefix=/ ABI=32

make
# It rarely breaks with the /includes.
make DESTDIR=$1 install -j1

cd ..
rm -rf gmp-$VER
