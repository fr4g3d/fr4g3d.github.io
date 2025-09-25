#!/bin/bash
#
clear
sudo apt update
sleep 3
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION <= '10' ]]; then
  echo "Cannot install on Debian <= 10 , only for Debian >= 11"
  exit
elif [[ $VERSION >= '11' ]]; then
  echo "Preparing Install ISPConfig"
fi
sleep 2
sudo apt-get install -y ssh openssh-server nano vim-nox lsb-release apt-transport-https ca-certificates wget git gnupg software-properties-common curl cron ntp
sudo apt-get install -y dbconfig-common postfix postfix-mysql mariadb-client mariadb-server openssl rkhunter binutils sudo getmail dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-managesieved dovecot-lmtpd
sudo apt-get install -y software-properties-common update-inetd dnsutils resolvconf clamav clamav-daemon zip unzip bzip2 xz-utils lzip borgbackup arj nomarch lzop cabextract apt-listchanges libnet-ldap-perl libauthen-sasl-perl daemon libio-string-perl libio-socket-ssl-perl libnet-ident-perl libnet-dns-perl libdbd-mysql-perl bind9 rspamd redis-server postgrey p7zip p7zip-full unrar-free lrzip
echo "Done Preparing..."
sleep 2
echo "Start ISPConfig Installer..."
sleep 2
wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --unattended-upgrades
sleep 2
#
#wget -N https://files.softaculous.com/install.sh
#sudo bash ./install.sh
#
exit
