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

wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --unattended-upgrades
sleep 2
#
#wget -N https://files.softaculous.com/install.sh
#sudo bash ./install.sh
#
exit
