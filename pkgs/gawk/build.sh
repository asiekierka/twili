#!/bin/sh -e
VER=4.0.1
test -e gawk-$VER.tar.gz || wget http://ftp.gnu.org/gnu/gawk/gawk-$VER.tar.gz
rm -rf gawk-$VER;tar -xf gawk-$VER.tar.gz
cd gawk-$VER


./configure --prefix=/ --libexecdir=/lib --disable-nls 

make
make DESTDIR=$1 install

ln -sf gawk $1/bin/awk

cd ..
rm -rf gawk-$VER
