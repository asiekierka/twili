#!/bin/sh -e
VER=3.82
test -e make-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/make/make-$VER.tar.bz2
rm -rf make-$VER;tar -xf make-$VER.tar.bz2
cd make-$VER
sed -i "s|__BEOS__|__BUILTIN_AR__|" arscan.c

./configure --prefix=/ --disable-nls
make CFLAGS="$CFLAGS -D__BUILTIN_AR__"
make DESTDIR=$1 install
cd ..
rm -rf make-$VER
