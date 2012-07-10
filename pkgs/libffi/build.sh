#!/bin/sh -e
VER=3.0.10
test -e libffi-$VER.tar.gz || wget ftp://sourceware.org/pub/libffi/libffi-$VER.tar.gz
rm -rf libffi-$VER;tar -xf libffi-$VER.tar.gz
cd libffi-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf libffi-$VER
