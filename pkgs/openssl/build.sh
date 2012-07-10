#!/bin/sh -e
VER=1.0.1a
test -e openssl-$VER.tar.gz || wget http://www.openssl.org/source/openssl-$VER.tar.gz
rm -rf openssl-$VER;tar -xf openssl-$VER.tar.gz
cd openssl-$VER

# Patches credit to Gentoo.

# RE-ENABLE MD2 ONCE MAKEDEPEND IS FIXED
patch -p0 <../openssl-1.0.1-ipv6.patch
patch -p1 <../openssl-1.0.1-parallel-build.patch
sed -i '/^"linux-x86_64/s/-DTERMIO/-DTERMIOS/' Configure
sed -i '/^"linux-elf/s/-DTERMIO/-DTERMIOS/' Configure
sed -i 's/defined(linux)/0/' crypto/ui/ui_openssl.c
#sed -i 's/#ifdef SIGACTION/#ifdef I_REALLY_WANT_THE_BUGGY_SIGACTION/' crypto/des/read_pwd.c crypto/ui/ui_openssl.c
# Non-shared
./config --prefix=/ --openssldir=/etc/ssl --libdir=lib zlib no-shared no-dso -Wa,--noexecstack -D_GNU_SOURCE
touch include/memory.h
make all || exit 1
make INSTALL_PREFIX=$1 MANDIR=/share/man install || exit 1
make clean
# Shared
./config --prefix=/ --openssldir=/etc/ssl --libdir=lib zlib no-dso -Wa,--noexecstack -fPIC -D_GNU_SOURCE
touch include/memory.h
make build_libs || exit 1
make build-shared || exit 1
cp -f *.so* /lib

cd ..
rm -rf openssl-$VER
