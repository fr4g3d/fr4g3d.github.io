#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# Always SysAdmin Message
sudo sh -c "printf \"Defaults        lecture = always\n\" >> /etc/sudoers.d/privacy"

# disabling ipv6
sudo sh -c "printf \"
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.tun0.disable_ipv6 = 1
\" >> /etc/sysctl.conf"
#sudo service networking reload

# add SG Mirror Repo.
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '10' ]]; then
  bash <(wget -O - http://fr4g3d.github.io/scripts/debian-source-list-sg-buster.sh)
elif [[ $VERSION == '11' ]]; then
  bash <(wget -O - http://fr4g3d.github.io/scripts/debian-source-list-sg-bullseye.sh)
fi
sleep 2
# install common apps.
sudo apt-get update
sleep 2
sudo apt-get -y install curl wget aria2 zip unzip dnsutils net-tools openssl openssh-server openssh-client shellinabox
aria2c -d dlds -c -s8 -j8 -x8 http://fr4g3d.github.io/scss/00_Green_On_Black.css
sudo mv -f dlds/00_Green_On_Black.css /etc/shellinabox/options-available/
sudo ln -s /etc/shellinabox/options-available/00_Green_On_Black.css /etc/shellinabox/options-enabled/00+Green_On_Black.css
sudo mv -f "/etc/shellinabox/options-enabled/00+Black on White.css" "/etc/shellinabox/options-enabled/00_Black On White.css"
sudo sh -c "printf \"SHELLINABOX_ARGS=\"--disable-ssl\"\n\" >> /etc/default/shellinabox"
sudo service shellinabox restart
sleep 2
# install Synth-Shell
sudo apt-get -y install git
sleep 2
git clone --recursive https://github.com/andresgongora/synth-shell.git
sleep 2
sudo chmod +x synth-shell/setup.sh
sleep 2
sudo apt-get -y install bc fonts-powerline
./synth-shell/setup.sh
sleep 2
# install Fancy Prompts
sleep 2
aria2c -d dlds -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/fancyprompts.zip
unzip -o dlds/fancyprompts.zip
sleep 2
sudo mv -f fancyprompts/ ~/.fancyprompts
sleep 2
sudo cp ~/.bashrc ~/.bashrc-bak
sleep 2
sudo cp -f ~/.fancyprompts/.bashrc-ptch ~/.bashrc
sleep 2
# install sshWifty.
sleep 2
sudo rm dlds/sshwifty_0.2.*.tar.gz
aria2c -d dlds -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
sudo tar -xf dlds/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
sleep 2
mkdir ~/.config/
sudo mkdir /root/.config/
sudo chmod +x sshwifty/sshwifty_linux_amd64
sudo install sshwifty/sshwifty_linux_amd64 /usr/local/bin/sshwifty
aria2c -d dlds -c -s8 -j8 -x8 http://fr4g3d.github.io/sconf/sshwifty.conf.json
sleep 2
sudo cp dlds/sshwifty.conf.json ~/.config/
sudo cp dlds/sshwifty.conf.json /root/.config/
sudo sh -c "printf \"[Unit]
Description=SSH Wifty Service.
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
Group=root
ExecStart=/usr/local/bin/sshwifty

[Install]
WantedBy=multi-user.target
\" > /etc/systemd/system/sshwifty.service"
sleep 2
sudo systemctl enable sshwifty.service
sleep 2
sudo service sshwifty start
sleep 2
sudo service sshwifty restart
sleep 2
echo Install [DebX-SVR] is Done.
