#!/bin/sh -e
VER=4.6.3
TOP=$(pwd)
test -e gcc-core-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$VER/gcc-core-$VER.tar.bz2
rm -rf gcc-$VER;tar -xf gcc-core-$VER.tar.bz2
cd gcc-$VER

sed -i -e 's|/lib/ld-linux.so.2|/lib/ld-musl-i386.so.1|' -e 's|/lib64/ld-linux-x86-64.so.2|/lib/ld-musl-x86_64.so.1|' gcc/config/i386/linux64.h gcc/config/i386/linux.h
sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in
sed -i 's/linux-gnu\* |/linux-gnu* | linux-musl* |/' config.sub

export CC="gcc -L/lib -I/include -D_GNU_SOURCE"
export CFLAGS="-m32 -D_GNU_SOURCE"

#-fgnu89-inline
LDFLAGS="-Wl,--no-keep-memory" ./configure \
    --with-newlib --with-headers=no --prefix=/ \
    --disable-multilib --disable-nls --disable-shared \
    --disable-mudflap --disable-libmudflap --disable-libssp \
    --disable-libgomp --disable-bootstrap --enable-lto --libdir=/lib \
    --libexecdir=/lib --mandir=/share/man --infodir=/share/info \
    --enable-languages=c --enable-clocale=generic \
    --with-target-libiberty=no --with-target-zlib=no --with-arch=i586 \
    --build=i386-unknown-linux-musl

make
make DESTDIR=$1 install-gcc install-lto-plugin install-target-libgcc
ln -sf gcc $1/bin/cc
cd ..
rm -rf gcc-$VER
