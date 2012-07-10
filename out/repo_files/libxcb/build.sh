#!/bin/sh -e
VER=1.7
PNAME=libxcb
test -e $PNAME-$VER.tar.bz2 || wget http://xcb.freedesktop.org/dist/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

mkdir hack
cp /bin/cat hack/xsltproc
PATH=hack:$PATH ./configure --prefix=/ --disable-build-docs || exit 1
make || exit 1
make -j1 DESTDIR=$1 install || exit 1

cd ..
rm -rf $PNAME-$VER
