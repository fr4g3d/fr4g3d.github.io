#!/bin/bash
#
# Three in One Installer for Server Bidang BMD - Kota Serang
#
clear
#

sleep 2
# install common for installing Common Downloader.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
rm dlds/ncbmd-debx.sh
rm dlds/install-lamp.sh
rm dlds/install-phpmyadmin.sh
rm dlds/install-speedtest.sh
rm dlds/install-kodexplorer.sh
rm dlds/install-nextcloud.sh
rm dlds/install-kvm-cockpitvm.sh
rm dlds/install-webmin.sh
echo "Install [NXC-BMD] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/ncbmd-debx.sh)
echo "Install [LAMP] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-lamp.sh)
echo "Install [FastCGi] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/enable-fastcgi.sh)
echo "Install [phpMyAdmin] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-phpmyadmin.sh)
echo "Install [LibreSpeedTest] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-speedtest.sh)
echo "Install [NextCloud] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-nextcloud.sh)
echo "Install [CockPit+KVM] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-kvm-cockpitvm.sh)
echo "Install [WebMin] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-webmin.sh)
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/ncbmd-debx.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-lamp.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-phpmyadmin.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-speedtest.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-kodexplorer.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-nextcloud.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-kvm-cockpitvm.sh
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/scripts/install-webmin.sh
#sleep 2
#sudo chmod +x dlds/*.sh
#sudo bash ./dlds/ncbmd-debx.sh
#sudo bash ./dlds/install-lamp.sh
#sudo bash ./dlds/install-phpmyadmin.sh
#sudo bash ./dlds/install-speedtest.sh
#udo bash ./dlds/install-kodexplorer.sh
#sudo bash ./dlds/install-nextcloud.sh
#sudo bash ./dlds/install-kvm-cockpitvm.sh
#sudo bash ./dlds/install-webmin.sh
sleep 2
clear
echo All Well Done.
sleep 3
