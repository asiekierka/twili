#!/bin/sh -e
VER=30
test -e zip$VER.tgz || wget ftp://ftp.info-zip.org/pub/infozip/src/zip$VER.tgz
rm -rf zip$VER;tar -xf zip$VER.tgz
cd zip$VER

make -f unix/Makefile generic_gcc
make -f unix/Makefile prefix=$1 install

cd ..
rm -rf zip$VER
