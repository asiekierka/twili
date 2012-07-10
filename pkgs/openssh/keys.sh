#!/bin/sh

makekey() {
        key=$1
        if [ "$key" = "rsa" ] ; then
                bits=2048
elif [ "$key" = "ecdsa" ] ; then
#no, thats not a typo
bits=521
        else
                bits=1024
        fi
filename=ssh_host_${key}_key
        rm -f ${filename}.pub
        rm -f ${filename}
        ssh-keygen -q -N "" -b $bits -t $key -f ${filename}
}

cd $1/etc/ssh

makekey rsa
makekey dsa
makekey ecdsa
