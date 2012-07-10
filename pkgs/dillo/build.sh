#!/bin/sh -e
VER=3.0.2
test -e dillo-$VER.tar.gz || wget http://fossies.org/unix/www/dillo-$VER.tar.gz
rm -rf dillo-$VER;tar -xf dillo-$VER.tar.gz
cd dillo-$VER

sed -i 's|<dirent.h>|<dirent.h>\n#include<sys/types.h>|' dpid/dpid_common.h
CFLAGS="-D_GNU_SOURCE" ./configure --enable-ipv6 --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf dillo-$VER
