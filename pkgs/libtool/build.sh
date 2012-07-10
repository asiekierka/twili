#!/bin/sh -e
VER=2.4.2
test -e libtool-$VER.tar.gz || wget http://ftp.task.gda.pl/pub/gnu/libtool/libtool-$VER.tar.gz
rm -rf libtool-$VER;tar -xf libtool-$VER.tar.gz
cd libtool-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf libtool-$VER
