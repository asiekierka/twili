#!/bin/sh -e
VER=1.2.12
test -e SDL_mixert-$VER.tar.gz || wget http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-$VER.tar.gz
rm -rf SDL_mixer-$VER;tar -xf SDL_mixer-$VER.tar.gz
cd SDL_mixer-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf SDL_mixer-$VER
