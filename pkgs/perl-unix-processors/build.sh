#!/bin/sh -e
VER=2.042
test -e Unix-Processors-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/W/WS/WSNYDER/Unix-Processors-$VER.tar.gz
rm -rf Unix-Processors-$VER;tar -xf Unix-Processors-$VER.tar.gz
cd Unix-Processors-$VER

perl Makefile.PL || exit 1
make || exit 1
make test || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf Unix-Processors-$VER
