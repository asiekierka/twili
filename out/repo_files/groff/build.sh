#!/bin/sh -e
VER=1.21
test -e groff-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/groff/groff-$VER.tar.gz
rm -rf groff-$VER;tar -xf groff-$VER.tar.gz
cd groff-$VER

./configure --prefix=/ --libexecdir=/lib --disable-nls 
make
make DESTDIR=$1 install

cd ..
rm -rf gawk-$VER
