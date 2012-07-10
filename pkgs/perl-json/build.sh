#!/bin/sh -e
VER=2.53
test -e JSON-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/M/MA/MAKAMAKA/JSON-$VER.tar.gz
rm -rf JSON-$VER;tar -xf JSON-$VER.tar.gz
cd JSON-$VER

perl Makefile.PL
make
make test
make DESTDIR=$1 install

cd ..
rm -rf JSON-$VER
