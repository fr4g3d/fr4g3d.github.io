#!/bin/bash
#
# Installer KVM/Qemu and Cockpit VM
#
clear
#

# install common apps for Downloader.
sudo apt -y install curl wget aria2
sleep 2
# install KVM/Qemu.
sudo apt -y install --no-install-recommends qemu qemu-kvm qemu-system libvirt-daemon libvirt-daemon-system libvirt-clients bridge-utils virt-manager virtinst
sleep 2
sudo systemctl enable --now libvirtd
sleep 2
sudo virsh net-start default
sleep 2
sudo service cockpit start
sleep 2
# install Cockpit VM App.
sudo apt -y install cockpit cockpit-machines
#sleep 2
# install Cockpit Navigator App.
# aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/cockpit-navigator_0.5.10-1focal_all.deb
# sudo apt -y install ./dlds/cockpit-navigator_0.5.10-1focal_all.deb
# sleep 2
# install Cockpit File-Sharing App.
#aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/cockpit-file-sharing_3.3.3-1focal_all.deb
#sudo apt -y install ./dlds/cockpit-file-sharing_3.3.3-1focal_all.deb
sleep 2
echo Done.
sleep 3
