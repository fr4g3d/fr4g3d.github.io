#!/bin/bash
#
# Nextcloud Server - Expander Storage.
#
clear
#

# install Nextcloud Virtual File System MIME.
printf "add inside section [General]"
printf "showExperimentalOptions=true"
sleep 3s
wget https://fr4g3d.github.io/sarch/nxcvfs-mime.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/nxcvfs-mime.tar.gz
sleep 2s
tar -xjf dlds/nxcvfs-mime.tar.gz
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