#!/bin/bash

#conseguir listado login

logins="$(ldapsearch -x -LLL dn | grep 'uid' |  tr '=' ' ' | cut -d ' ' -f 3 | cut -d ',' -f1)"

for user in $logins
do	
  echo -e "$user\n$user" | smbpasswd -a $user
  echo "$user samba done"
  line=$(getent passwd $user)
  uid=$(echo $line | cut -d: -f3)
  gid=$(echo $line | cut -d: -f4)
  homedir=$(echo $line | cut -d: -f6)
  echo "$user $uid $gid $homedir"
  if [ ! -d $homedir ]; then
    mkdir -p $homedir
    cp -ra /etc/skel/. $homedir
    chown -R $uid.$gid $homedir
  fi
  echo "$user home creado"
done
