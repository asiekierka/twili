#!/bin/sh -e
VER=1.4
PNAME=xkeyboard-config
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/data/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

if false ; then

# fuck this, we just copy the stuff over
mkdir -p $1/share/X11/xkb/rules
for f in base evdev xfree98 base.lst evdev.lst xkb.dtd README base.xml evdev.xml; do
  cp "rules/$f" "$1/share/X11/xkb/rules/"
done
for d in compat geometry keycodes keymap semantics symbols types; do
  cp -r "$d" "$1/share/X11/xkb"
  mv "$1/share/X11/xkb/$d/$d.dir" "$1/share/X11/xkb/$d.dir"
  rm "$1/share/X11/xkb/$d/Makefile*" || true
done

fi

./configure --with-xkb_base=$1/share/X11/xkb --with-xkb-rules-symlink=xorg || exit 1
make || exit 1
make install || exit 1

cd ..
rm -rf $PNAME-$VER
