#!/bin/sh -e
VER=269
PNAME=xterm
test -e $PNAME-$VER.tgz || wget ftp://invisible-island.net/$PNAME/$PNAME-$VER.tgz
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tgz
cd $PNAME-$VER

# the configure script fails to pass all required -l dependencies to some test
# for some reason ld fails to find them in /lib, unless we use -rpath= or this
export LD_RUN_PATH=$1/lib,/lib

# Gleiches mit gleichem vergelten.
CFLAGS="-Wl,-rpath-link=$1/lib:/lib -g -D__GNU__ -D__GLIBC__=2 -D__GLIBC_MINOR__=10 -D_POSIX_SOURCE -D_GNU_SOURCE" ./configure --prefix=/ --mandir=/share/man--enable-256-color --enable-88-color --with-pcre  || exit 1
cat <<EOF >>ptyx.h
#ifndef HACKY_HACKY_GETPT 
#define HACKY_HACKY_GETPT
static inline int getpt() { return open("/dev/ptmx",O_RDWR|O_NOCTTY); }
#endif
EOF
make || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
