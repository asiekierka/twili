#!/bin/sh -e
VER=1.0.25
test -e alsa-lib-$VER.tar.bz2 || wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$VER.tar.bz2
rm -rf alsa-lib-$VER;tar -xf alsa-lib-$VER.tar.bz2
cd alsa-lib-$VER

patch -p1 <../alsa-lib-1.0.25-2.patch
cp ../hsearch_r.c src/compat/hsearch_r.c

#musl doesn't support PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP, this is a hack
sed -i 's@PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP@{{{1,0,0,0,0,0,0,0,0,0}}}@' src/conf.c
sed -i 's,%L,%ll,g' src/conf.c test/midiloop.c
 
CFLAGS="-include stdlib.h -D_POSIX_SOURCE -D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE -DF_SETSIG=10" ./configure --prefix=/ --disable-python
make V=1
make DESTDIR=$1 install

cd ..
rm -rf alsa-lib-$VER
