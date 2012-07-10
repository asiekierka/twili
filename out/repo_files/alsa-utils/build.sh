#!/bin/sh -e
VER=1.0.25
test -e alsa-utils-$VER.tar.bz2 || wget http://gentoo.netnitco.net/distfiles/alsa-utils-$VER.tar.bz2
rm -rf alsa-utils-$VER;tar -xf alsa-utils-$VER.tar.bz2
cd alsa-utils-$VER

sed -i 's,#include <sys/signal.h>,#include <signal.h>,' aplay/aplay.c alsaloop/alsaloop.c
sed -i 's,__UCLIBC__,_ALSA_UTILS_HACKS,' alsamixer/volume_mapping.c

CFLAGS="-D_GNU_SOURCE -D_ALSA_UTILS_HACKS -Dlseek64=lseek -Dopen64=open -Ddirent64=dirent" ./configure --prefix=/ --disable-xmlto --disable-alsaloop --disable-alsatest || exit 1

make
make DESTDIR=$1 install -j1

cd ..
rm -rf alsa-utils-$VER
