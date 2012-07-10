#!/bin/sh -e
VER=3.2.14
LOGONAME=cutie_mark
test -e linux-$VER.tar.bz2 || wget -c http://www.kernel.org/pub/linux/kernel/v3.0/linux-$VER.tar.bz2
rm -rf linux-$VER;tar -xf linux-$VER.tar.bz2
cd linux-$VER

#cat ../linux-noperl-capflags.patch ../linux-noperl-headers.patch \
#    ../linux-noperl-timeconst.patch ../linux-posix-sed.patch | patch -p1

#cp ../logo_$LOGONAME.ppm drivers/video/logo/logo_linux_clut224.ppm
make CC=gcc allnoconfig ARCH=i386 HOSTCFLAGS="-D_GNU_SOURCE" KCONFIG_ALLCONFIG=../linux.config
#make i386_defconfig HOSTCFLAGS="-D_GNU_SOURCE"
make CC=gcc HOSTCFLAGS=-D_GNU_SOURCE ARCH=i386 INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p $1/include/
cp -rv dest/include/* $1/include/

make CC=gcc ARCH=i386 HOSTCFLAGS=-D_GNU_SOURCE
make CC=gcc INSTALL_MOD_PATH=$1 ARCH=i386 modules_install

mkdir -p $1/boot
cp System.map $1/boot/
cp arch/x86/boot/bzImage $1/boot/vmlinuz-$VER

cd ..
