#!/bin/sh -e
VER=1.6
test -e tmux-$VER.tar.gz || wget http://downloads.sourceforge.net/project/tmux/tmux/tmux-$VER/tmux-$VER.tar.gz
rm -rf tmux-$VER;tar -xf tmux-$VER.tar.gz
cd tmux-$VER

CFLAGS="$CFLAGS -D_GNU_SOURCE" ./configure --prefix=/
make
make DESTDIR=$1 install

mkdir -p $1/etc
cd ..
cp tmux.conf $1/etc
cp tmux-status.sh $1/etc
rm -rf tmux-$VER
