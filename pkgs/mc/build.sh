#!/bin/sh -e
VER=4.8.2
test -e mc-$VER.tar.bz2 || wget http://www.midnight-commander.org/downloads/mc-$VER.tar.bz2
rm -rf mc-$VER;tar -xf mc-$VER.tar.bz2
cd mc-$VER

./configure --prefix=/ --disable-nls --disable-vfs-ftp
make
make DESTDIR=$1 install -j1

cd ..
rm -rf mc-$VER
