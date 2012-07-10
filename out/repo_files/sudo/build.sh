#!/bin/sh -e
VER=1.8.4p4
test -e sudo-$VER.tar.gz || wget http://www.sudo.ws/sudo/dist/sudo-$VER.tar.gz
rm -rf sudo-$VER;tar -xf sudo-$VER.tar.gz
cd sudo-$VER

./configure --prefix=/
sed -i "s/#define _SUDO_CONFIG_H/#define _SUDO_CONFIG_H\n#define NFDBITS (8*sizeof(unsigned long))/" config.h
make || exit 1
make DESTDIR=$1 install

cd ..
rm -rf sudo-$VER
