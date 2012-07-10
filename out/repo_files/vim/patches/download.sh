#!/bin/sh
BEGIN=502
PATCHLEVEL=591
for n in $(seq -w $BEGIN $PATCHLEVEL); do
  echo "Grabbing patch $n/$PATCHLEVEL"
  wget ftp://ftp.vim.org/pub/vim/patches/7.3/7.3.$n
done

