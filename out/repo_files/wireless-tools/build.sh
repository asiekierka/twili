#!/bin/sh -e
VER=29
test -e wireless_tools.$VER.tar.gz || wget http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.$VER.tar.gz
rm -rf wireless_tools.$VER;tar -xf wireless_tools.$VER.tar.gz
cd wireless_tools.$VER

sed -i 's/-I./-I. -D_GNU_SOURCE/' Makefile
make
make PREFIX=$1 install

cd ..
rm -rf wireless_tools.$VER
