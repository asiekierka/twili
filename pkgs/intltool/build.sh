#!/bin/sh -e
VER=0.40.6
test -e intltool-$VER.tar.bz2 || wget http://ftp.gnome.org/pub/gnome/sources/intltool/0.40/intltool-$VER.tar.bz2
rm -rf intltool-$VER;tar -xf intltool-$VER.tar.bz2
cd intltool-$VER

./configure --prefix="$1/" || exit 1
make || exit
make install || exit

cd ..
rm -rf intltool-$VER
