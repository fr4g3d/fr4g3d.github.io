#!/bin/bash
#
# Installer WebMin
#
clear
#

# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# install WebMin.
curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sh setup-repos.sh
sudo apt-get -y install webmin --install-recommends
sleep 2
echo Install [WebMin] is Done.
sleep 3
