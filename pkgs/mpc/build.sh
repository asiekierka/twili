#!/bin/sh -e
VER=0.9
test -e mpc-$VER.tar.gz || wget http://www.multiprecision.org/mpc/download/mpc-$VER.tar.gz
rm -rf mpc-$VER;tar -xf mpc-$VER.tar.gz
cd mpc-$VER

./configure --prefix=/


make
make DESTDIR=$1 install

cd ..
rm -rf mpc-$VER
