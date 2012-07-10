#!/bin/sh -e
VER=2.3.1
test -e nano-$VER.tar.gz || wget http://www.nano-editor.org/dist/v2.3/nano-$VER.tar.gz
rm -rf nano-$VER;tar -xf nano-$VER.tar.gz
cd nano-$VER

./configure --prefix=/ --disable-wrapping || exit 1
make || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf nano-$VER
