#!/bin/bash
#
# Three in One Installer for Server Bidang BMD - Kota Serang
#
clear
#

sleep 2
# install common for installing Common Downloader.
sudo apt update
sudo apt install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/ncbmd-debx.sh
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/install-livehelperchat.sh
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/install-nextcloud.sh
sudo chmod +x dlds/*.sh
sudo ./dlds/ncbmd-debx.sh
sudo ./dlds/install-livehelperchat.sh
sudo ./dlds/install-nextcloud.sh
sleep 2
echo Done.
sleep 3
clear