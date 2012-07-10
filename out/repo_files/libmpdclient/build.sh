#!/bin/sh -e
VER=2.7
PNAME=libmpdclient
EXT=tar.bz2
test -e $PNAME-$VER.$EXT || wget http://downloads.sourceforge.net/project/musicpd/$PNAME/$VER/$PNAME-$VER.$EXT
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.$EXT
cd $PNAME-$VER

sed -i 's/<errno.h>/<errno.h>\n#include <sys\/select.h>/' src/socket.c
sed -i 's/<unistd.h>/<unistd.h>\n#include <sys\/select.h>/' src/sync.c

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
