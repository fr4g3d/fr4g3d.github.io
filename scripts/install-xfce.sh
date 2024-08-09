#!/bin/bash
#
# Installer XFCE-DE
#
clear
#

# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# install XFCE-DE.
sudo apt install xfce4 xfce4-goodies
sleep 2
sudo apt install lightdm
sleep 2
echo Done.
echo Please Reboot your OS.
sleep 3
