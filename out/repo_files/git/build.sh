#!/bin/sh -e
VER=1.7.9.6
test -e git-$VER.tar.bz2 || wget http://git-core.googlecode.com/files/git-$VER.tar.gz
rm -rf git-$VER;tar -xf git-$VER.tar.gz
cd git-$VER

LDFLAGS="$LDFLAGS -Wl,-rpath-link=/lib" ./configure --with-openssl --prefix=/ --without-python
make
make DESTDIR=$1 install

cd ..
rm -rf git-$VER
