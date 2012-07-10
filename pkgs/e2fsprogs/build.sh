#!/bin/sh -e
VER=1.42.2
test -e e2fsprogs-$VER.tar.bz2 || wget http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v$VER/e2fsprogs-$VER.tar.gz
rm -rf e2fsprogs-$VER;tar -xf e2fsprogs-$VER.tar.gz
cd e2fsprogs-$VER

sed -i "s|sys/signal.h|signal.h|" misc/fsck.c
CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ --disable-defrag --enable-libblkid --enable-libuuid --enable-uuidd --enable-elf-shlibs --disable-tls
make
make DESTDIR=$1 install

cd ..
rm -rf e2fsprogs-$VER
