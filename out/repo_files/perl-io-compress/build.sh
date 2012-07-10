#!/bin/sh -e
VER=2.049
test -e IO-Compress-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/IO-Compress-$VER.tar.gz
rm -rf IO-Compress-$VER;tar -xf IO-Compress-$VER.tar.gz
cd IO-Compress-$VER

perl Makefile.PL || exit 1
make || exit 1
make test || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf IO-Compress-$VER
