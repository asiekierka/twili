#!/bin/sh

# This script only serves the purpose of downloading the newest pppkg.

cd $1/bin
# TODO: I don't even update the repository anymore. More important things to be done.
# wget --no-check-certificate -O pppkg https://raw.github.com/asiekierka/pppkg/master/pppkg.pl
chmod 755 pppkg
