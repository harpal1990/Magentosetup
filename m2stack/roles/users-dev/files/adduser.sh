#!/bin/sh
if [ $# -ne 1 ]
        then echo "usage: $0 <username>"
        exit 1
fi

HOST=`/bin/hostname`
USER=$1
ME=`/usr/bin/whoami`

if [ $ME != root ]
        then echo "Run this script under sudo or root user"
        exit 2
fi

randpass () {

MATRIX="0123456789ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
# ==> Password will consist of alphanumeric characters.
LENGTH="12"

while [ "${n:=1}" -le "$LENGTH" ]
do
        PASS="$PASS${MATRIX:$(($RANDOM%${#MATRIX})):1}"
        let n+=1
done

}

create_user() {
        randpass
        echo "creating user $USER"
        mkdir /home/yahoo
        /usr/sbin/useradd -s /bin/bash -d /home/yahoo $USER
#       echo "$PASS" | chpasswd --stdin $USER
        echo $USER:$PASS | chpasswd
        chown $USER.$USER /home/yahoo
        echo "password is $PASS"
}

create_user
