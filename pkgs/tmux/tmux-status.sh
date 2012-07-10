#!/bin/sh

nmeter "%10c %m" &
sleep 1
kill $!
