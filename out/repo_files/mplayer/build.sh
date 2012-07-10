#!/bin/sh -e
test -e mplayer-export-snapshot.tar.bz2 || wget http://www.mplayerhq.hu/MPlayer/releases/mplayer-export-snapshot.tar.bz2
tar -xf mplayer-export-snapshot.tar.bz2
cd mplayer-export-*

sed -i 's/__linux__/__broken_scsi__/' stream/stream_dvd_common.c

mkdir -p ffmpeg
cd ffmpeg
wget -O ffmpeg.tgz 'http://git.videolan.org/?p=ffmpeg.git;a=snapshot;h=HEAD;sf=tgz'
tar xf ffmpeg.tgz
rm ffmpeg.tgz
cd ffmpeg*HEAD*
mv * ..
cd ../..

./configure --extra-cflags="-D_GNU_SOURCE -O4" --disable-win32dll --disable-vidix
make
make -j1 DESTDIR=$1 install

cd ..
rm -rf mplayer-export-*
