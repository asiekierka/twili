#!/bin/sh -e
VER=1.2.12
test -e SDL_image-$VER.tar.gz || wget http://www.libsdl.org/projects/SDL_image/release/SDL_image-$VER.tar.gz
rm -rf SDL_image-$VER;tar -xf SDL_image-$VER.tar.gz
cd SDL_image-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf SDL_image-$VER
