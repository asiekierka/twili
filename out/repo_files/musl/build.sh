#!/bin/sh -e

# TODO: If you don't make this a pppkg.pl thing, I will destroy you - or myself. -- asie
PPPKG_ARCH=i386
VER=0.9.2
test -e musl-$VER.tar.gz || wget http://www.etalabs.net/musl/releases/musl-$VER.tar.gz
rm -rf musl-$VER;tar -xf musl-$VER.tar.gz
cd musl-$VER
cat >config.mak <<EOF
#
# musl config.mak template (original in dist/config.mak)
#

# Target CPU architecture. Supported values: i386, x86_64
ARCH = $PPPKG_ARCH

# Installation prefix. DO NOT use /, /usr, or /usr/local !
prefix = /

# Installation prefix for musl-gcc compiler wrapper.
exec_prefix = /

# Location for the dynamic linker ld-musl-\$(ARCH).so.1
syslibdir = /lib/

# Uncomment if you want to build i386 musl on a 64-bit host
#CFLAGS += -m32

# Uncomment for smaller code size.
#CFLAGS += -fomit-frame-pointer -mno-accumulate-outgoing-args

# Uncomment for warnings (as errors). Might need tuning to your gcc version.
#CFLAGS += -Werror -Wall -Wpointer-arith -Wcast-align -Wno-parentheses -Wno-char-subscripts -Wno-uninitialized -Wno-sequence-point -Wno-missing-braces -Wno-unused-value -Wno-overflow -Wno-int-to-pointer-cast

# Uncomment if you want to disable building the shared library.
# SHARED_LIBS =
EOF
# Maximize stack
sed -i "s/(16384-PAGE_SIZE)/(65536-PAGE_SIZE)/" src/internal/pthread_impl.h

patch -p1 <../musl-$VER-longjmp.patch || exit 1
patch -p1 <../musl-$VER-rtld.patch || exit 1
patch -p1 <../musl-$VER-arm_init.patch || exit 1
patch -p1 <../musl-$VER-arm_sigsetjmp.patch || exit 1

CC=gcc make
make install DESTDIR=$1
cd ..
rm -rf musl-$VER

sed -i "s,AAAA,$PPPKG_ARCH," musl-gcc
sed -i "s,PPPP,," musl-gcc
sed -i "s,gcc=rawcc,gcc=gcc," musl-gcc
rm $1/bin/musl-gcc
cp musl-gcc $1/bin

ln -sf /lib/libc.so $1/bin/ldd
