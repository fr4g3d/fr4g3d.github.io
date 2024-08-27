#!/bin/bash
#
# Enable FastCGI
#
clear
#

sleep 2
# install common for installing Common Downloader.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
sudo apt update
sleep 2
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '10' ]]; then
  phpver = "7.3"
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/000-default10.conf
  sudo mv -f dlds/000-default10.conf /etc/apache2/sites-available/000-default.conf
#  bash <(wget -O - https://fr4g3d.github.io/scripts/debian-source-list-sg-buster.sh)
elif [[ $VERSION == '11' ]]; then
  phpver = "7.4"
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/000-default11.conf
  sudo mv -f dlds/000-default11.conf /etc/apache2/sites-available/000-default.conf
#  bash <(wget -O - https://fr4g3d.github.io/scripts/debian-source-list-sg-bullseye.sh)
fi
sudo apt install php php-fpm
sleep 2
sudo systemctl restart php$phpver-fpm
sleep 2
sudo systemctl status php$phpver-fpm
sleep 2
sudo a2enmod alias proxy proxy_fcgi
sleep 2
sudo systemctl restart apache2.service
sleep 2
echo Well Done.
sleep 3
clear
