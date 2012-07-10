#!/bin/sh
# Modify. Important!
APP = @APP
VER = @VER
test -e $APP-$VER.tar.gz || wget $APP-$VER.tar.gz
rm -rf $APP-$VER;tar -xf $APP-$VER.tar.gz
cd $APP-$VER

./configure
make
make -j1 install DESTDIR=$1
cd ..
rm -rf $APP-$VER


