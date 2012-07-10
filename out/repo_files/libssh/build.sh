#!/bin/sh -e
VER=0.5.0
test -e libssh-$VER.tar.gz || wget http://libssh.org/files/0.5/libssh-$VER.tar.gz
rm -rf libssh-$VER;tar -xf libssh-$VER.tar.gz
cd libssh-$VER

cp ../libssh-Makefile ./Makefile
cp ../libssh-config.mak ./config.mak
touch include/libssh/config.h
touch include/config.h
echo -ne "#include <fcntl.h>\n" > ../tmp-libssh.h
cat include/libssh/libssh.h >> ../tmp-libssh.h
cp ../tmp-libssh.h include/libssh/libssh.h
rm ../tmp-libssh.h
mkdir -p $1/include/
mkdir -p $1/lib/
CFLAGS="-Os -s -D_GNU_SOURCE -I./include -std=gnu99 -Wall -Wextra" make src || exit 1
make DESTDIR=$1 install || exit 1

cd ..
rm -rf libssh-$VER
