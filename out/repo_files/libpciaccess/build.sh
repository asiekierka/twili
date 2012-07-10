#!/bin/sh -e
VER=0.13.1
PNAME=libpciaccess
test -e $PNAME-$VER.tar.bz2 || wget http://xorg.freedesktop.org/releases/individual/lib/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

sed -i 's/<sys\/fcntl.h>/<fcntl.h>/' include/*.h src/*.h src/*.c
sed -i -e 's/pwrite64/pwrite/' -e 's/pread64/pread/' src/linux_sysfs.c
sed -i 's/<errno.h>/<errno.h>\n#include <limits.h>/' src/linux_sysfs.c
sed -i 's/#if defined(__i386__) || defined(__x86_64__) || defined(__arm__)/#if 0/' src/linux_sysfs.c

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ || exit 1
make || exit 1
make DESTDIR=$1 install -j1 || exit 1

cd ..
rm -rf $PNAME-$VER
