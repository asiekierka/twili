#!/bin/sh -e
VER=2.41
test -e XML-Parser-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/XML-Parser-$VER.tar.gz
rm -rf XML-Parser-$VER;tar -xf XML-Parser-$VER.tar.gz
cd XML-Parser-$VER

perl Makefile.PL || exit 1
LDFLAGS="$LDFLAGS -static" CFLAGS="$CFLAGS -Wl,-rpath-link=/lib" make || exit 1
make test || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf XML-Parser-$VER
