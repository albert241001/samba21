#! /bin/bash
/opt/docker/install.sh && echo "Install Ok"
/opt/docker/auth.sh 
/opt/docker/home.sh
useradd -m -s /bin/bash unix01
useradd -m -s /bin/bash unix02
useradd -m -s /bin/bash unix03
echo -e "unix01\unix01" | smbpasswd -a unix01
echo -e "unix02\unix02" | smbpasswd -a unix02
echo -e "unix03\unix03" | smbpasswd -a unix03

cp /opt/docker/ldap.conf /etc/ldap/
cp /opt/docker/nslcd.conf /etc/
cp /opt/docker/login.defs /etc/login.defs
cp /opt/docker/pam_mount.conf.xml /etc/security
cp /opt/docker/nsswitch.conf /etc
cp /opt/docker/common-session /etc/pam.d/
service nscd start
service nslcd start 
/usr/sbin/smbd && echo "smb Ok"
/usr/sbin/nmbd && echo "nmb  Ok"

/bin/bash



