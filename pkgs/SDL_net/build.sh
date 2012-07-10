#!/bin/sh -e
VER=1.2.8
test -e SDL_net-$VER.tar.gz || wget http://www.libsdl.org/projects/SDL_net/release/SDL_net-$VER.tar.gz
rm -rf SDL_net-$VER;tar -xf SDL_net-$VER.tar.gz
cd SDL_net-$VER

./configure --prefix=/
make
make DESTDIR=$1 install

cd ..
rm -rf SDL_net-$VER
