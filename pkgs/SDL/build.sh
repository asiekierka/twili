#!/bin/sh -e
VER=1.2.15
test -e SDL-$VER.tar.gz || wget http://www.libsdl.org/release/SDL-$VER.tar.gz
rm -rf SDL-$VER;tar -xf SDL-$VER.tar.gz
cd SDL-$VER

cd src/video/fbcon
sed -i -e "s|__u16|ushort|" -e "s|__u32|uint|" *.c *.h
sed -i "s|defined(FB_TYPE_VGA_PLANES)|defined(DONT_TOUCH_THIS)|" SDL_fbvideo.c
cd ../../..
./configure --prefix=/
# TODO: Find real reason for X11 breaking strings.h
sed -i "s|#define HAVE_STRINGS_H 1|#undef HAVE_STRINGS_H|" include/SDL_config.h
make
make DESTDIR=$1 install

cd ..
rm -rf SDL-$VER
