#!/bin/sh -e
VER=0.16.8
PNAME=mpd
EXT=tar.gz
test -e $PNAME-$VER.$EXT || wget http://downloads.sourceforge.net/project/musicpd/$PNAME/$VER/$PNAME-$VER.$EXT
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.$EXT
cd $PNAME-$VER

CFLAGS="-D_GNU_SOURCE -DM_PI_2=1.5707963268" ./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf $PNAME-$VER
