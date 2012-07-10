#!/bin/sh -e
VER=3.5.9
PNAME=libXpm
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/lib/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

sed -i 's/USE_GETTEXT="yes"/USE_GETTEXT="no"/' configure || exit 1
./configure --prefix=/ || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
