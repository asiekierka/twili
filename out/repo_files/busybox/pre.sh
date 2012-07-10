#!/bin/sh
if [ -f $1/bin/busybox ]; then
 busybox cp $1/bin/busybox $1/bin/old_busybox
 busybox rm $1/bin/ln
 busybox rm $1/bin/rm
 busybox rm $1/bin/cp
 busybox rm $1/bin/mv
 busybox ln -s old_busybox $1/bin/ln
 busybox ln -s old_busybox $1/bin/rm
 busybox ln -s old_busybox $1/bin/cp
 busybox ln -s old_busybox $1/bin/mv
fi
