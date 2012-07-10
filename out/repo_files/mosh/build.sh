#!/bin/sh -e
VER=1.1.3
test -e mosh-$VER.tar.gz || wget https://github.com/downloads/keithw/mosh/mosh-$VER.tar.gz
rm -rf mosh-$VER;tar -xf mosh-$VER.tar.gz
cd mosh-$VER

sed -i 's/test "x$ac_cv_have_decl_htobe64" = xyes;/true;/' configure
sed -i 's/__STRING(expr)/#expr/' src/util/fatal_assert.h src/util/dos_assert.h

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install
cd ..
rm -rf mosh-$VER
