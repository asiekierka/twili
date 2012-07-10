#!/bin/sh -e
VER=4.6.3
TOP=$(pwd)
test -e gcc-core-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$VER/gcc-core-$VER.tar.bz2
test -e gcc-g++-$VER.tar.bz2 || wget http://ftp.gnu.org/gnu/gcc/gcc-$VER/gcc-g++-$VER.tar.bz2
rm -rf gcc-$VER;tar -xf gcc-core-$VER.tar.bz2
tar xf gcc-g++-$VER.tar.bz2
cd gcc-$VER

#more g++ hackery
sed -i 's,# include <syscall.h>,#include <sys/syscall.h>,' ./libstdc++-v3/libsupc++/guard.cc
#sed -i 's,# define _GLIBCXX_USE_FUTEX,,' ./libstdc++-v3/libsupc++/guard.cc

#todo check if this isnt to intrusive
sed -i 's,gcc_no_link=yes,gcc_no_link=no,' ./libstdc++-v3/configure

#and even more g++ hackery
mv ./libstdc\+\+-v3/config/os/gnu-linux ./libstdc\+\+-v3/config/os/gnu-linux.org
cp -r ./libstdc\+\+-v3/config/os/generic ./libstdc\+\+-v3/config/os/gnu-linux
#g++ hackery done

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
    --enable-languages=c++ --enable-clocale=generic \
    --with-target-libiberty=no --with-target-zlib=no --with-arch=i586 \
    --build=i386-unknown-linux-musl

make
make DESTDIR=$1 install-gcc install-target-libstdc++-v3
# Leave only g++.
echo "removing gcc binaries"
rm -rf $1/bin/*gcc
rm -rf $1/bin/*gcc-$VER
rm -rf $1/bin/*gcov
echo "removing duplicate libraries"
cp $1/lib/gcc/i386-unknown-linux-musl/$VER/cc1plus $1
rm -r $1/lib/gcc/i386-unknown-linux-musl/$VER/
mkdir $1/lib/gcc/i386-unknown-linux-musl/$VER/
mv $1/cc1plus $1/lib/gcc/i386-unknown-linux-musl/$VER/
echo "removing replicated man files"
rm -r $1/share/man/man7
rm $1/share/man/man1/gcc.1
rm $1/share/man/man1/gcov.1
cd ..
rm -rf gcc-$VER
