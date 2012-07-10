#!/bin/sh -e
VER=0.70.1
test -e blackbox-$VER.tar.bz2 || wget http://downloads.sourceforge.net/project/blackboxwm/blackboxwm/Blackbox%20$VER/blackbox-$VER.tar.bz2
rm -rf blackbox-$VER;tar -xf blackbox-$VER.tar.bz2
cd blackbox-$VER

#sed -i 's/<stdlib.h>/<stdlib.h>\n#include <string.h>/' lib/Image.cc
#sed -i 's/<stdio.h>/<stdio.h>\n#include <string.h>/' lib/Resource.cc
patch -p1 <../fix-ftbfs-gcc-4.3.diff
patch -p1 <../fix-spelling-errors.diff
patch -p1 <../manpage-tidy-up.diff
patch -p1 <../pkgconfig-requires-private.diff
patch -p1 <../textpropertytostring-unconditional.diff

CFLAGS="-D_GNU_SOURCE" LDFLAGS="-Wl,-rpath-link=/lib" ./configure --prefix=/ --disable-nls
make
make DESTDIR=$1 install -j1

cd ..
rm -rf blackbox-$VER
