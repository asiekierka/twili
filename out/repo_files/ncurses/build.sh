#!/bin/sh -e
VER=5.9
test -e ncurses-$VER.tar.gz || wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$VER.tar.gz
rm -rf ncurses-$VER;tar -xf ncurses-$VER.tar.gz
cd ncurses-$VER

# Workaround for no ext. deps
cp ../ncurses-fallback.c ncurses/fallback.c

CC="$CC -D_GNU_SOURCE" ./configure --prefix=/ --with-normal \
	--enable-sigwinch --with-shared --with-fallbacks="linux vt100 xterm xterm-256color" \
	--without-cxx-binding --includedir=/include --mandir=/share/man --disable-nls </dev/ptmx || exit 1 

make || exit 1
make DESTDIR=$1 install || exit 1

ln -s libncurses.so $1/lib/libcurses.so
ln -s libncurses.a $1/lib/libcurses.a
cd ..
rm -rf ncurses-$VER
