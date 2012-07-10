#!/bin/sh
if [ -f $1/bin/old_busybox ]; then
 rm $1/bin/ln
 busybox ln -s busybox $1/bin/ln
 rm $1/bin/old_busybox
fi
