#!/bin/sh -e
VER=3.03
test -e cowsay-$VER.tar.gz || wget http://www.nog.net/~tony/warez/cowsay-$VER.tar.gz
rm -rf cowsay-$VER;tar -xf cowsay-$VER.tar.gz
cd cowsay-$VER

sed -i 's/%PREFIX%,$PREFIX/%PREFIX%,\//' install.sh

./install.sh "$1"

cd ..
rm -rf cowsay-$VER
