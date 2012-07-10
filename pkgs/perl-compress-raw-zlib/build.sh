#!/bin/sh -e
VER=2.051
test -e Compress-Raw-Zlib-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/Compress-Raw-Zlib-$VER.tar.gz
rm -rf Compress-Raw-Zlib-$VER;tar -xf Compress-Raw-Zlib-$VER.tar.gz
cd Compress-Raw-Zlib-$VER

perl Makefile.PL || exit 1
make || exit 1
make test || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf Compress-Raw-Zlib-$VER
