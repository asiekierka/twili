#!/bin/sh -e
VER=20120212
test -e ca-certificates_$VER.tar.gz || wget http://ftp.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_$VER.tar.gz
rm -rf ca-certificates-$VER;tar -xf ca-certificates_$VER.tar.gz
cd ca-certificates-$VER

patch -p1 < ../ca-certificates.patch || exit 1

# Fix mozilla because no Python.
cd mozilla
rm Makefile
cp ../spi-inc.org/Makefile Makefile
wget http://twi.asiekierka.pl/mozilla-ca-cert-20120414.tar.bz2
tar xf mozilla-ca-cert-20120414.tar.bz2
rm -rf mozilla-ca-cert-20120414.tar.bz2
cd ..

make || exit 1
make DESTDIR="$1" install || exit 1

mkdir -p "$1/etc/ssl/certs" || exit 1

( cd "$1/share/ca-certificates/"
  find . -name '*.crt' | sort | cut -b3- > "$1/etc/ca-certificates.conf" )

#cp sbin/update-ca-certificates . || exit 1
#sed -e 's#=/etc/#=${DESTDIR}/etc/#' -i update-ca-certificates
#sed -e 's#=/share/#=${DESTDIR}/share/#' -i update-ca-certificates
#sed -e 's#=/local/#=${DESTDIR}/local/#' -i update-ca-certificates
#cp update-ca-certificates ucc-old

#patch -p0 < ../hack.patch || exit 1
#DESTDIR="$1" sh ./update-ca-certificates --fresh || exit 1

cd ..
#rm -rf ca-certificates-$VER

