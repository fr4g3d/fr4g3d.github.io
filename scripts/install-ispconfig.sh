#!/bin/bash
#
sudo apt update
sleep 3
wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --unattended-upgrades
sleep 2
#wget -N https://files.softaculous.com/install.sh
#sudo bash ./install.sh
exit
