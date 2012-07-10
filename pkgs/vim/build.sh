#!/bin/sh -e
VER=7.3
TARDIR=vim73
PATCHLEVEL=591
test -e vim-$VER.tar.bz2 || wget ftp://ftp.vim.org/pub/vim/unix/vim-$VER.tar.bz2
rm -rf vim-$VER;tar -xf vim-$VER.tar.bz2
cd $TARDIR

for n in $(seq -w 001 $PATCHLEVEL); do
  echo "Adding patch $n/$PATCHLEVEL"
  patch -p0 <../patches/$VER.$n
done

CFLAGS="-D_GNU_SOURCE" ./configure --prefix=/ --mandir=/share/man --localstatedir=/var/lib/vim \
  --disable-nls --disable-netbeans --disable-gui --with-x=no --enable-multibyte || exit 1
make -C src auto/osdef.h || exit 1
sed -i '/define stack_t/d' src/auto/config.h
sed -i '/setenv/d' src/auto/osdef.h
sed -i '/putenv/d' src/auto/osdef.h

make || exit 1
make -j1 VIMRCLOC=/etc DESTDIR=$1 install || exit 1

cd ..
rm -rf $TARDIR
