#!/bin/sh -e
VER=2.33
test -e dejavu-fonts-ttf-$VER.tar.bz2 || wget http://sourceforge.net/projects/dejavu/files/dejavu/$VER/dejavu-fonts-ttf-$VER.tar.bz2
rm -rf dejavu-fonts-ttf-$VER;tar -xf dejavu-fonts-ttf-$VER.tar.bz2
cd dejavu-fonts-ttf-$VER/ttf/
mkdir -p $1/share/fonts/X11/TTF/
cp -R * $1/share/fonts/X11/TTF/

cd ../..
rm -rf dejavu-fonts-ttf-$VER
