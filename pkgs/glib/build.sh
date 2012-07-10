#!/bin/sh -e
VER=2.32.1
test -e glib-$VER.tar.xz || wget http://ftp.gnome.org/pub/GNOME/sources/glib/2.32/glib-$VER.tar.xz
rm -rf glib-$VER;tar -xf glib-$VER.tar.xz
cd glib-$VER

patch -p1 <../glib-no-tests.patch
patch -p1 <../glib-no-codegen.patch
autoreconf --force --install --verbose || exit $?
CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/ --disable-modular-tests
make
make || exit 1
make DESTDIR=$1 install

cd ..
rm -rf glib-$VER
