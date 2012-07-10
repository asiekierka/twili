#!/bin/sh -e
VER=0.8.8.4
PNAME=libmodplug
EXT=tar.gz
test -e $PNAME-$VER.$EXT || wget http://downloads.sourceforge.net/project/modplug-xmms/$PNAME/$VER/$PNAME-$VER.$EXT
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.$EXT
cd $PNAME-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
