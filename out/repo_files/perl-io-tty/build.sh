#!/bin/sh -e
VER=1.10
test -e IO-Tty-$VER.tar.gz || wget http://search.cpan.org/CPAN/authors/id/T/TO/TODDR/IO-Tty-$VER.tar.gz
rm -rf IO-Tty-$VER;tar -xf IO-Tty-$VER.tar.gz
cd IO-Tty-$VER

perl Makefile.PL
make
make test
make DESTDIR=$1 install

cd ..
rm -rf IO-Tty-$VER
