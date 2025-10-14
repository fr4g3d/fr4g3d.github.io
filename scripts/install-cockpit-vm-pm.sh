#!/bin/bash
#
# Installer KVM/Qemu, Cockpit VM and Cockpit Podman
#
clear
#
start_time=$SECONDS
# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# install Cockpit VM App.
sudo apt-get -y install cockpit cockpit-pcp cockpit-machines cockpit-podman qemu-system libvirt-clients libvirt-daemon-system
sleep 2
clear
# install FileBrowser App.
echo "Install [FileBrowser] App"
sleep 2
#sudo curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | sudo bash
mkdir dlds
aria2c -d dlds -c -m3 -s8 -j8 -x8 -V https://github.com/filebrowser/filebrowser/releases/download/v2.32.0/linux-amd64-filebrowser.tar.gz
aria2c -d dlds -c -m3 -s8 -j8 -x8 -V http://fr4g3d.github.io/sconf/filebrowser.db
tar -xvzf dlds/linux-amd64-filebrowser.tar.gz -C dlds/
sudo chmod +x dlds/filebrowser
sudo install dlds/filebrowser /usr/local/bin/filebrowser
sudo cp dlds/filebrowser.db /root/filebrowser.db
dpkg -S /usr/bin/nohup

sudo sh -c "printf \"
[registries.search]
registries = ['docker.io', 'quay.io']
[registries.insecure]
registries = []
\" >> /etc/containers/registries.conf"
sleep 1
mkdir -p ~/.config/containers
bash -c "printf \"
[engine]
cgroup_manager = '"cgroupfs"'
\" >> ~/.config/containers/containers.conf"
sleep 1

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
sudo usermod -aG kvm $(whoami)
sudo usermod -aG libvirt $(whoami)
echo Type: 'newgrp kvm'
echo Type: 'newgrp libvirt'
sleep 2
sudo adduser $USER libvirt
sudo systemctl enable virtlogd.socket
sleep 2
sudo systemctl restart virtlogd.socket
sleep 2
sudo systemctl enable --now libvirtd
sleep 2
#sudo ip link set down virbr0
#sleep 2
#sudo brctl delbr virbr0
#sleep 2
sudo virsh net-autostart default
sleep 2
sudo virsh net-start default
sleep 2
sudo service cockpit restart
sleep 2
echo 
podman run docker.io/library/hello-world
sleep 3
echo 
podman run quay.io/podman/hello
sleep 2
echo 
echo Install [CockPit+KVM+Podman] is Done.
sleep 3
end_time=$SECONDS
duration=$((end_time - start_time))
hours=$((duration / 360))
minutes=$((duration / 60))
seconds=$((duration % 60))
echo "Script completed in $hours hours, $minutes minutes and $seconds seconds."
