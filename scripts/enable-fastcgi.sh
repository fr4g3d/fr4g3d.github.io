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
sudo apt install php php-fpm
sleep 2
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '10' ]]; then
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/000-default10.conf
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/default10-ssl.conf
  sleep 2
  sudo mv -f dlds/000-default10.conf /etc/apache2/sites-available/000-default.conf
  sudo mv -f dlds/default10-ssl.conf /etc/apache2/sites-available/default-ssl.conf
  sleep 2
  sudo systemctl restart php7.3-fpm
#  bash <(wget -O - https://fr4g3d.github.io/scripts/debian-source-list-sg-buster.sh)
elif [[ $VERSION == '11' ]]; then
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/000-default11.conf
  aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sconf/default11-ssl.conf
  sleep 2
  sudo mv -f dlds/000-default11.conf /etc/apache2/sites-available/000-default.conf
  sudo mv -f dlds/default11-ssl.conf /etc/apache2/sites-available/default-ssl.conf
  sleep 2
  sudo systemctl restart php7.4-fpm
#  bash <(wget -O - https://fr4g3d.github.io/scripts/debian-source-list-sg-bullseye.sh)
fi
sleep 2
sudo a2enmod alias proxy proxy_fcgi
sleep 2

sudo sh -c "printf \"
; nxcbmd set config FPM:
pm.max_children = 256
pm.max_requests = 2048
pm.start_servers = 64
pm.min_spare_servers = 32
pm.max_spare_servers = 192
pm.process_idle_timeout = 155
\" >> /etc/php/7.3/fpm/pool.d/www.conf"

sleep 1
sudo systemctl restart php7.*-fpm.service
sleep 2
sudo systemctl restart apache2.service
sleep 2
echo Enable [PHP-FPM/FastCGi] is Done.
sleep 3
clear
