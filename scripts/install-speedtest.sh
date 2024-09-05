#!/bin/bash
#
# Installer LibreSpeedTest
#
clear
#

# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# Download LibreSpeedTest
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/spdtest.zip
sleep 2
# Install LibreSpeedTest
unzip -o dlds/spdtest.zip
sleep 2
sudo mv -f speedtest/ /var/www/html/.apps/
sleep 2
echo Install [LibreSpeedTest] is Done.
sleep 3
