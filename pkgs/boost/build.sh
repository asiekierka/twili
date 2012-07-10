#!/bin/sh -e
VER=1_49_0
VER2=1.49.0
test -e boost_$VER.tar.bz2 || wget http://downloads.sourceforge.net/project/boost/boost/$VER2/boost_$VER.tar.bz2
rm -rf boost_$VER;tar -xf boost_$VER.tar.bz2
cd boost_$VER

# Patches.
sed -i "s/if defined( OS_MVS )/if 1/" tools/build/v2/engine/fileunix.c
sed -i "s/#include <wait.h>//" tools/build/v2/engine/execunix.c
sed -i 's/#ifdef HAVE_PYTHON/#define _GNU_SOURCE\n#ifdef HAVE_PYTHON/' tools/build/v2/engine/jam.h
sed -i 's/#if defined(__linux)/#if 0/' libs/locale/src/util/numeric.hpp
sed -i 's/defined(BOOST_HAS_PTHREAD_YIELD)/0/' libs/thread/src/pthread/thread.cpp

./bootstrap.sh
./b2
./bjam install --prefix=$1

cd ..
rm -rf boost_$VER
# We don't tend to do this but we really should
rm -rf boost_$VER.tar.bz2
