#!/bin/sh -e
VER=0.1.1
test -e $VER.tar.gz || wget http://hg.suckless.org/st/archive/$VER.tar.gz
rm -rf st-$VER;tar -xf $VER.tar.gz
cd st-$VER

echo "PREFIX = /" >>config.mk
make config.h || exit 1
sed -i '/FONT/s/".*"/"fixed"/' config.h
make LIBS="-lX11 -lxcb -lXau -lXdmcp" || exit 1
make DESTDIR=$1 install -j1 || exit 1

cd ..
rm -rf st-$VER
