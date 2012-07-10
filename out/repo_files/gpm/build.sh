#!/bin/sh -e
VER=1.20.6
test -e gpm-$VER.tar.bz2 || wget http://www.nico.schottelius.org/software/gpm/archives/gpm-$VER.tar.bz2
rm -rf gpm-$VER;tar -xf gpm-$VER.tar.bz2
cd gpm-$VER

sed -i 's|-Werror||' Makefile.include.in
#patch -p0 < ../gpm-1.99.7-fix-doc.patch
CC="musl-gcc -D_GNU_SOURCE" ./configure --prefix=/
sed -i "s|sys/fcntl.h|fcntl.h|" src/daemon/gpm.c src/lib/liblow.c
sed -i 's|chmod 400 $@|echo "chmod 400 $@"|' doc/Makefile
sed -i 's|SA_INTERRUPT|SA_RESTART|' src/prog/gpm-root.*
cd src
patch -p0 < ../../gpm-ft-1.20.6.patch
#patch -p0 < ../../gpm-fix-daemon.patch
patch -p0 < ../../gpm-root.patch
cd ..
make LDFLAGS="-Wl,-rpath-link=/lib"
make DESTDIR=$1 install -j1

cd ..
rm -rf gpm-$VER
