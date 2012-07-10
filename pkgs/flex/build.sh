#!/bin/sh -e
VER=2.5.35
test -e flex-$VER.tar.bz2 || wget http://downloads.sourceforge.net/sourceforge/flex/flex-$VER.tar.bz2
rm -rf flex-$VER;tar -xf flex-$VER.tar.bz2
cd flex-$VER

CC="$CC -D_GNU_SOURCE -DSTDC_HEADERS" ./configure --prefix=/ --disable-nls --infodir=/share/info --mandir=/share/man || exit 1
make || exit 1
make -j1 DESTDIR="$1" install || exit 1

cd ..
rm -rf flex-$VER
