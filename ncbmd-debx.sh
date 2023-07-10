#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
sudo sh -c "printf \"\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.all.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.default.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.lo.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.tun0.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo service networking reload

# install common apps.
sudo apt update
sleep 2
sudo apt -y install dnsutils openssl openssh-server openssh-client shellinabox curl wget aria2 zip unzip
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/00_Green_On_Black.css
sudo mv -f dlds/00_Green_On_Black.css /etc/shellinabox/options-available/
sudo ln -s /etc/shellinabox/options-available/00_Green_On_Black.css /etc/shellinabox/options-enabled/00+Green_On_Black.css
sudo mv -f "/etc/shellinabox/options-enabled/00+Black on White.css" "/etc/shellinabox/options-enabled/00_Black On White.css"
sudo sh -c "printf \"SHELLINABOX_ARGS=\"--disable-ssl\"\n\" >> /etc/default/shellinabox"
sudo service shellinabox restart
sleep 2
sudo rm dlds/sshwifty_0.2.*.tar.gz
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
sudo tar -xf dlds/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
sleep 2
mkdir .config/
sudo chmod +x sshwifty/sshwifty_linux_amd64
sudo install sshwifty/sshwifty_linux_amd64 /usr/local/bin/sshwifty
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sshwifty.conf.json
sleep 2
sudo cp dlds/sshwifty.conf.json ~/.config/
printf "[Unit]\n" > sshwifty.service
printf "Description=SSH Wifty Service.\n" >> sshwifty.service
printf "After=network.target\n" >> sshwifty.service
printf "StartLimitIntervalSec=0\n" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Service]\n" >> sshwifty.service
printf "Type=simple\n" >> sshwifty.service
printf "Restart=always\n" >> sshwifty.service
printf "RestartSec=1\n" >> sshwifty.service
printf "User=aset\n" >> sshwifty.service
printf "ExecStart=/usr/local/bin/sshwifty\n" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Install]\n" >> sshwifty.service
printf "WantedBy=multi-user.target\n" >> sshwifty.service
printf "\n" >> sshwifty.service
sleep 2
sudo mv -f sshwifty.service /etc/systemd/system/sshwifty.service
sudo systemctl enable sshwifty.service
sleep 2
sudo service sshwifty start
sleep 2
sudo service sshwifty restart
sleep 2
echo Done.
