#!/bin/sh
# Modify. Important!
APP=ruby
VER=1.8.7-p358
test -e $APP-$VER.tar.gz || wget http://ftp.ruby-lang.org/pub/$APP/1.8/$APP-$VER.tar.gz
rm -rf $APP-$VER;tar -xf $APP-$VER.tar.gz
cd $APP-$VER

sed -i 's/#include <unistd.h>/#include <unistd.h>\n#undef __syscall/' io.c

./configure
make
make -j1 install DESTDIR=$1
cd ..
rm -rf $APP-$VER


