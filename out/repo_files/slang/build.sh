#!/bin/sh -e
VER=2.1.4
test -e slang-$VER.tar.bz2 || wget ftp://ftp.fu-berlin.de/pub/unix/misc/slang/v2.1/slang-$VER.tar.bz2
rm -rf slang-$VER;tar -xf slang-$VER.tar.bz2
cd slang-$VER

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install -j1

cd ..
rm -rf slang-$VER
