#!/bin/sh -e
VER=5.07
test -e file-$VER.tar.gz || wget ftp://ftp.astron.com/pub/file/file-$VER.tar.gz
rm -rf file-$VER;tar -xf file-$VER.tar.gz
cd file-$VER

CC="$CC -static -D_GNU_SOURCE -D_BSD_SOURCE" ./configure -C --prefix=/ --disable-shared || exit 1
sed -i 's/memory.h/string.h/' src/encoding.c src/ascmagic.c
make || exit 1
make DESTDIR="$1" -j1 install || exit 1

cd ..
rm -rf file-$VER
