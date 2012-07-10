#!/bin/sh -e
VER=7.25.0
test -e curl-$VER.tar.bz2 || wget http://curl.haxx.se/download/curl-$VER.tar.bz2
rm -rf curl-$VER;tar -xf curl-$VER.tar.bz2
cd curl-$VER
CONFFLAGS="--prefix=/"
echo Checking for packages...
pppkg -l > list.tmp
if grep "openssl" list.tmp
then
	CONFFLAGS="$CONFFLAGS --with-ssl"
fi
if grep "libssh2" list.tmp
then
	CONFFLAGS="$CONFFLAGS --with-libssh2"
fi
if grep "librtmp" list.tmp
then
        CONFFLAGS="$CONFFLAGS --with-librtmp"
fi
if grep "libidn" list.tmp
then
        CONFFLAGS="$CONFFLAGS --with-libidn"
fi
rm list.tmp
CFLAGS="-D_GNU_SOURCE -Wl,-rpath-link=/lib" ./configure $CONFFLAGS || exit 1
make || exit 1
make -j1 DESTDIR=$1 install || exit 1
cd ..
rm -rf curl-$VER
