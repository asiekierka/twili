#!/bin/sh -e
VER=5.8p2
test -e openssh-$VER.tar.gz || wget http://ftp.spline.de/pub/OpenBSD/OpenSSH/portable/openssh-$VER.tar.gz
rm -rf openssh-$VER;tar -xf openssh-$VER.tar.gz
cd openssh-$VER

cp ../openssh-hacks.h .
CC="gcc -include openssh-hacks.h -D_BSD_SOURCE -DMISSING_HOWMANY -DMISSING_FD_MASK -DMISSING_NFDBITS" ./configure --prefix=/ \
  --sbindir=/bin --libexecdir=/lib/ssh --sysconfdir=/etc/ssh \
  --with-privsep-user=nobody \
  --with-md5-passwords --with-mantype=man --mandir=/share/man \
  --disable-strip --disable-lastlog --disable-utmpx --disable-btmp || exit 1

mkdir netinet
touch netinet/in_systm.h

sed -i '/USE_BTMP/d' config.h

make || exit 1

#key generation is disabled for packaging
#use pkg/sshd-keys to make the keys "manually"
make -j1 DESTDIR=$1 install-nokeys || exit 1
mkdir -p $1/etc/ssh/
mkdir -p $1/etc/service/
cp -R ../service/sshd $1/etc/service/
cd ..
rm -rf openssh-$VER
