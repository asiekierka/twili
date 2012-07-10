#!/bin/sh -e
VER=1.13.4
test -e wget-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/wget/wget-$VER.tar.bz2
rm -rf wget-$VER;tar -xf wget-$VER.tar.bz2

cd wget-$VER
cp ../hack.h src/
sed -i 's|#include "wget.h"|#include "wget.h"\n#include "hack.h"|' src/host.c

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/ --with-ssl=openssl
make
make DESTDIR=$1 install

cd ..
rm -rf wget-$VER
