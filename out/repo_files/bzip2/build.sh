#!/bin/sh -e
VER=1.0.6
test -e bzip2-$VER.tar.gz || wget http://bzip.org/$VER/bzip2-$VER.tar.gz
rm -rf bzip2-$VER;tar -xf bzip2-$VER.tar.gz
cd bzip2-$VER

make
make PREFIX=$1 install
make -f Makefile-libbz2_so
cp -R libbz2.so* $1/lib
ln -s libbz2.so.$VER $1/lib/libbz2.so
cd ..
rm -rf bzip2-$VER
