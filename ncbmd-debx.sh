#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
printf "\n" >> /etc/sysctl.conf
printf "net.ipv6.conf.all.disable_ipv6 = 1\n" >> /etc/sysctl.conf
printf "net.ipv6.conf.default.disable_ipv6 = 1\n" >> /etc/sysctl.conf
printf "net.ipv6.conf.lo.disable_ipv6 = 1\n" >> /etc/sysctl.conf
printf "net.ipv6.conf.tun0.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo service networking reload

# install common apps.
sudo apt update
sleep 1
sudo apt install openssl openssh-server openssh-client curl wget zip unzip
