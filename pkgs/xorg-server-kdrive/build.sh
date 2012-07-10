!/bin/sh -e
VER=1.9.5
PNAME=xorg-server
test -e $PNAME-$VER.tar.bz2 || wget ftp://ftp.x.org/pub/individual/xserver/$PNAME-$VER.tar.bz2
rm -rf $PNAME-$VER;tar -xf $PNAME-$VER.tar.bz2
cd $PNAME-$VER

sed -i 's/termio.h/termios.h/' hw/xfree86/os-support/xf86_OSlib.h 
# XXX implement me, for now cast float to int.
sed -i 's/lroundf\?//' dix/getevents.c
# Bash symlinked to busybox doesn't work with dolt.
sed -i 's/dolt_supported=yes/dolt_supported=no/' configure
cd hw/kdrive/fbdev
sed -i 's/__u16/u_short/' *.c *.h
cd ../../..

CFLAGS="-D__gid_t=gid_t -D__uid_t=uid_t -DNOFILES_MAX=256 -D_GNU_SOURCE -I/include/pixman-1" \
  ./configure --prefix=/ \
    --disable-glx --disable-dri \
    --disable-xorg --disable-unit-tests \
    --enable-kdrive --enable-kdrive-evdev || exit 1
make || exit 1
make DESTDIR="$1" install || exit 1

#ln -sf Xfbdev $1/bin/X
#copy our hacky X launcher script to /bin...
cp ../X $1/bin/X

cd ..
rm -rf $PNAME-$VER
