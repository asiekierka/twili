#!/bin/sh -e
VER=8.71
test -e urwfonts-$VER.tar.bz2 || wget http://mirror.cs.wisc.edu:82/pub/mirrors/ghost/AFPL/GhostPCL/urwfonts-$VER.tar.bz2
rm -rf urwfonts-$VER;tar -xf urwfonts-$VER.tar.bz2
cd urwfonts-$VER
mkdir -p $1/share/fonts/X11/TTF/
cp -R * $1/share/fonts/X11/TTF/

cd ..
rm -rf urwfonts-$VER
