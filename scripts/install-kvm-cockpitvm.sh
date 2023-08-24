#!/bin/bash
#
# Installer KVM/Qemu and Cockpit VM
#
clear
#

# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# install Cockpit VM App.
sudo apt-get -y install cockpit cockpit-machines
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
sudo service cockpit start
sleep 2
# install FileBrowser App.
sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | sudo bash
dpkg -S /usr/bin/nohup

sudo sh -c "printf \"[Unit]
Description=FileBrowser Service
After=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
Group=root
ExecStart=/usr/local/bin/filebrowser -a 0.0.0.0 -p 8787 -r /home -d /root/filebrowser.db

[Install]
WantedBy=multi-user.target
\" >> filebrowserd.service"
sleep 2
sudo mv -f filebrowserd.service /etc/systemd/system/filebrowserd.service
sleep 2
sudo systemctl enable filebrowserd.service
sleep 2
sudo service filebrowserd start
sleep 2
sudo service filebrowserd restart
sleep 2
# nohup filebrowser -a 0.0.0.0 -p 8787 -r /home
sleep 2
echo Done.
sleep 3
