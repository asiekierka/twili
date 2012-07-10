#!/bin/sh -e
VER=1.9.5
PNAME=xorg-server
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/xserver/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

export LDFLAGS="$LDFLAGS -Wl,-z,lazy"

sed -i 's/termio.h/termios.h/' hw/xfree86/os-support/xf86_OSlib.h 
# XXX implement me, for now cast float to int.
sed -i 's/lroundf\?//' dix/getevents.c
# Bash symlinked to busybox doesn't work with dolt.
sed -i 's/dolt_supported=yes/dolt_supported=no/' configure
cd hw/kdrive/fbdev
sed -i 's/__u16/u_short/' *.c *.h
cd ../../..
sed -i 's/#ifdef I_SETSIG/#if 0/' hw/xfree86/os-support/shared/sigio.c
sed -i -e 's/#elif !defined(__mc68000__)/#elif 0/' hw/xfree86/os-support/linux/lnx_video.c
sed -i 's/#ifdef __GLIBC__/#if 1/' hw/xfree86/common/xf86pciBus.c

CFLAGS="-fno-stack-protector -D__gid_t=gid_t -D__uid_t=uid_t -DNOFILES_MAX=256 -D_GNU_SOURCE -I/include/pixman-1" \
  ./configure --prefix=/ --disable-glx --disable-dri \
    --enable-composite --enable-xfbdev --enable-xorg \
    --disable-aiglx --disable-config-hal --disable-config-dbus \
    --disable-dmx --disable-tslib --disable-xnest --disable-xephyr \
    --disable-unit-tests || exit 1

sed -i 's/EXTRA_DIST = /EXTRA_DIST = shared\/ioperm_noop.c /' hw/xfree86/os-support/Makefile

make || exit 1
make DESTDIR="$1" install || exit 1

#ln -sf Xfbdev $1/bin/X
#copy our hacky X launcher script to /bin...
cp ../X $1/bin/X

cd ..
rm -rf $PNAME-$VER
