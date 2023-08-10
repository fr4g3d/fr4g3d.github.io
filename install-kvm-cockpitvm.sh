#!/bin/bash
#
# Installer KVM/Qemu and Cockpit VM
#
clear
#

# install common apps and Downloader.
sudo apt -y install curl wget aria2 coreutils
sleep 2
# install Cockpit VM App.
sudo apt -y install cockpit cockpit-machines
sleep 2
sudo systemctl enable --now libvirtd
sleep 2
sudo virsh net-autostart default
sleep 2
sudo virsh net-start default
sleep 2
sudo service cockpit start
sleep 2
sudo usermod -aG kvm $(whoami)
sudo usermod -aG libvirt $(whoami)
newgrp kvm
newgrp libvirt
sleep 2
# install FileBrowser App.
sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | sudo bash
dpkg -S /usr/bin/nohup
nohup filebrowser -a 0.0.0.0 -p 8787 -r /home &
sleep 2
echo Done.
sleep 3
