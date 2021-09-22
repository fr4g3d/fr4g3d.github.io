#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
sudo printf "\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.all.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.default.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.lo.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.tun0.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo service networking reload

# install common apps.
sudo apt update
sleep 1
sudo apt install openssl openssh-server openssh-client curl wget zip unzip
wget https://github.com/nirui/sshwifty/releases/download/0.2.14-beta-release-prebuild/sshwifty_0.2.14-beta-release_linux_amd64.tar.gz
tar -xf sshwifty_0.2.14-beta-release_linux_amd64.tar.gz -C sshwifty/
cd sshwifty/
