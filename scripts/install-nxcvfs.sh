#!/bin/bash
#
# Nextcloud Desktop - Virtual File System MIME.
#
clear
#
sudo apt-get -y install curl wget aria2 zip unzip tar gzip
clear
# install Nextcloud Virtual File System MIME.
printf "add inside section [General]\n"
printf "showExperimentalOptions=true\n\n"
rm dlds/nxcvfs-mime.tar.gz
sleep 3s
#wget https://fr4g3d.github.io/sarch/nxcvfs-mime.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/nxcvfs-mime.tar.gz
sleep 2s
tar -xf dlds/nxcvfs-mime.tar.gz -C dlds/
sleep 2s
mkdir -p ~/.local/share/mime/packages/
mkdir -p ~/.local/share/applications/
cp dlds/nxcvfs-mime/nxcvfs.xml ~/.local/share/mime/packages/
cp dlds/nxcvfs-mime/Nextcloud-VFS.desktop ~/.local/share/applications/
update-mime-database ~/.local/share/mime/
sleep 2s
printf "Well Done.."
sleep 3s
clear
exit 0
