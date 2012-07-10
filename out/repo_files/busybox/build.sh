#!/bin/sh -e
VER=1.19.4
test -e busybox-$VER.tar.bz2 || wget http://busybox.net/downloads/busybox-$VER.tar.bz2
rm -rf busybox-$VER;tar -xf busybox-$VER.tar.bz2
cd busybox-$VER

cat ../busybox-musl-fixes.patch | patch -p1

make allnoconfig HOSTCFLAGS="-D_GNU_SOURCE " KCONFIG_ALLCONFIG=../busybox.config
make CFLAGS_busybox="$CFLAGS -Wl,-z,muldefs -static" HOSTCFLAGS="-D_GNU_SOURCE" HOSTCC=gcc CC=$CC
mkdir -p $1/bin/
cp busybox $1/bin/
cd ..
rm -rf busybox-$VER

cd $1/bin/
for i in $(./busybox --list);do
    ln -s busybox $i
done
# We have a reason for doing this.
rm ln
ln -s old_busybox ln
