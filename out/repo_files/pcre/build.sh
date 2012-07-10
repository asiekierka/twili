#!/bin/sh -e
VER=8.30
test -e pcre-$VER.tar.bz2 || wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.30.tar.bz2
rm -rf pcre-$VER;tar -xf pcre-$VER.tar.bz2
cd pcre-$VER

./configure --prefix=/ --enable-utf
make
make DESTDIR=$1 install

cd ..
rm -rf pcre-$VER
