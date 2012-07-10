#!/bin/sh -e
VER=1.1-20120215
test -e dialog_$VER.orig.tar.gz || wget http://ftp.us.debian.org/debian/pool/main/d/dialog/dialog_$VER.orig.tar.gz
rm -rf dialog-$VER;tar -xf dialog_$VER.orig.tar.gz
cd dialog-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf dialog-$VER
