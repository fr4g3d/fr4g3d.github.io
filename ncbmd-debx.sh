#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
sudo printf "\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.all.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.default.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.lo.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo printf "net.ipv6.conf.tun0.disable_ipv6 = 1\n" >> /etc/sysctl.conf
sudo service networking reload

# install common apps.
sudo apt update
sleep 2
sudo apt install openssl openssh-server openssh-client curl wget aria2 zip unzip
aria2c -d dlds/ -c -x 16 https://github.com/nirui/sshwifty/releases/download/0.2.14-beta-release-prebuild/sshwifty_0.2.14-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
tar -xf dlds/sshwifty_0.2.14-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
cd sshwifty/
chmod +x sshwifty_linux_amd64
sudo install sshwifty_linux_amd64 /usr/local/bin/sshwifty
cp sshwifty.conf.example.json ~/.config/sshwifty.conf.json
cd 
printf "[Unit]" > sshwifty.service
printf "Description=SSH Wifty Service." >> sshwifty.service
printf "After=network.target" >> sshwifty.service
printf "StartLimitIntervalSec=0" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Service]" >> sshwifty.service
printf "Type=simple" >> sshwifty.service
printf "Restart=always" >> sshwifty.service
printf "RestartSec=1" >> sshwifty.service
printf "User=aset" >> sshwifty.service
printf "ExecStart=/usr/local/bin/sshwifty" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Install]" >> sshwifty.service
printf "WantedBy=multi-user.target" >> sshwifty.service
printf "\n" >> sshwifty.service
sudo mv sshwifty.service /etc/systemd/system/sshwifty.service
sudo systemctl enable sshwifty.service
sudo service sshwifty start
sleep 3
clear
