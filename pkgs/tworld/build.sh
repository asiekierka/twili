#!/bin/sh -e
VER=1.3.0
test -e tworld-$VER.tar.gz || wget http://www.muppetlabs.com/~breadbox/pub/software/tworld/tworld-$VER-CCLP2.tar.gz
rm -rf tworld-$VER;tar -xf tworld-$VER-CCLP2.tar.gz
cd tworld-$VER

./configure --prefix=/
make
# Hack!
sed -i "s|prefix = /|prefix = $1|" Makefile
make install

cd ..
rm -rf tworld-$VER
