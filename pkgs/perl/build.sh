#!/bin/sh -e
VER=5.16.0
test -e perl-$VER.tar.gz || wget http://www.cpan.org/src/5.0/perl-$VER.tar.gz
rm -rf perl-$VER;tar -xf perl-$VER.tar.gz
cd perl-$VER

sed -i 's,-fstack-protector,-fnostack-protector,g' ./Configure

CC="gcc" ./Configure -des -Accflags="-D_GNU_SOURCE" \
  -Dprefix=/ -Dvendorprefix=/ -Dinstallprefix=/ \
  -Dprivlib=/share/perl5/core_perl \
  -Darchlib=/lib/perl5/core_perl \
  -Dsitelib=/share/perl5/site_perl \
  -Dsitearch=/lib/perl5/site_perl \
  -Dvendorlib=/share/perl5/vendor_perl \
  -Dvendorarch=/lib/perl5/vendor_perl \
  -Dscriptdir=/bin \
  -Dsitescript=/bin \
  -Dvendorscript=/bin \
  -Dinc_version_list=none \
  -Dman1dir=/share/man/man1 -Dman1ext=1perl \
  -Dman3dir=/share/man/man3 -Dman3ext=3perl

make
make install DESTDIR=$1

# DEPRECATED as of 5.16.0
# cd ext/POSIX
# perl Makefile.PL
# make
# make install DESTDIR=$1

cd ../../..
rm -rf perl-$VER
