#!/bin/sh -e
VER=2.049
test -e Compress-Raw-Bzip2-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/P/PM/PMQS/Compress-Raw-Bzip2-$VER.tar.gz
rm -rf Compress-Raw-Bzip2-$VER;tar -xf Compress-Raw-Bzip2-$VER.tar.gz
cd Compress-Raw-Bzip2-$VER

perl Makefile.PL || exit 1
make || exit 1
make test || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf Compress-Raw-Bzip2-$VER
