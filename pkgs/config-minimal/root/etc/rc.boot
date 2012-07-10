#!/bin/sh
#rc.boot shamelessly ripped off from github.com/rofl0r/sabotage

export PATH=/local/bin:/bin

echo Twili Linux 0.01 [rc.boot]

cd /
mount -t proc proc /proc
mount -t sysfs sysfs /sys

hwclock -u -s

swapon -a

hostname $(cat /etc/hostname)
ifconfig lo up

mkdir -p /dev/shm /dev/pts
mount -o remount,rw /
mount -a

echo /bin/mdev > /proc/sys/kernel/hotplug
mdev -s
mount -a

syslogd

[ -f /etc/random-seed ] && cat /etc/random-seed >/dev/urandom
dd if=/dev/urandom of=/etc/random-seed count=1 bs=512 2>/dev/null

dmesg >/var/log/dmesg.log

[ -x /etc/rc.local ] && /etc/rc.local
