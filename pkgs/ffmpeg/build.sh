#!/bin/sh -e
VER=0.10.2
test -e ffmpeg-$VER.tar.bz2 || wget http://ffmpeg.org/releases/ffmpeg-$VER.tar.bz2
rm -rf ffmpeg-$VER;tar -xf ffmpeg-$VER.tar.bz2
cd ffmpeg-$VER

sed -i -e "s/pr -n -t/cat/" -e "s/pr -r -3 -t/cat/" -e "s/pr -3 -t/cat/" configure
CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/ || exit 1
make || exit 1
make install DESTDIR=$1 || exit 1

cd ..
rm -rf ffmpeg-$VER
