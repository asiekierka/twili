#!/bin/sh -e
VER=0.18.1.1
test -e gettext-$VER.tar.gz || wget http://ftp.gnu.org/pub/gnu/gettext/gettext-$VER.tar.gz
rm -rf gettext-$VER;tar -xf gettext-$VER.tar.gz
cd gettext-$VER

./configure --prefix=/ --disable-nls
make
make DESTDIR=$1 install

cd ..
rm -rf gettext-$VER
