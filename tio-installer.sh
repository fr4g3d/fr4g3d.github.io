#!/bin/bash
#
# Three in One Installer for Server Bidang BMD - Kota Serang
#
clear
#

sleep 2
# install common for installing Common Downloader.
sudo apt update
sudo apt -y install curl wget zip unzip aria2
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/ncbmd-debx.sh
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/install-lamp.sh
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/install-livehelperchat.sh
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/install-nextcloud.sh
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/install-kodexplorer.sh
sudo chmod +x dlds/*.sh
sudo ./dlds/ncbmd-debx.sh
sudo ./dlds/install-lamp.sh
sudo ./dlds/install-livehelperchat.sh
sudo ./dlds/install-nextcloud.sh
sudo ./dlds/install-kodexplorer.sh
sleep 2
echo All Well Done.
sleep 3
clear
