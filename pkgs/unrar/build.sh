#!/bin/sh -e
VER=4.1.1
test -e unrarsrc-$VER.tar.gz || wget http://www.rarlab.com/rar/unrarsrc-$VER.tar.gz
rm -rf unrar;tar -xf unrarsrc-$VER.tar.gz
cd unrar

make -f makefile.unix
make -f makefile.unix DESTDIR=$1 install

cd ..
rm -rf unrar
