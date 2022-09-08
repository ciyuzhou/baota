#!/bin/bash

/usr/sbin/sshd
/usr/sbin/crond

for file in `ls /etc/init.d`
do if [ -x /etc/init.d/${file} ];  then 
    /etc/init.d/$file restart
fi done
bt default

tail -f /dev/null
