#!/bin/sh -e
VER=2.4.1
test -e protobuf-$VER.tar.bz2 || wget http://protobuf.googlecode.com/files/protobuf-$VER.tar.bz2
rm -rf protobuf-$VER;tar -xf protobuf-$VER.tar.bz2
cd protobuf-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf protobuf-$VER
