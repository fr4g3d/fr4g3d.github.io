#!/bin/bash
#
# Installer KVM/Qemu and Cockpit VM
#
clear
#

# install common apps and Downloader.
sudo apt -y install curl wget aria2 coreutils
sleep 2
# install FlexiSiP.
sudo sh -c "printf \"
# For Debian 9
# deb [arch=amd64] http://linphone.org/snapshots/debian stretch stable # hotfix beta alpha
# For Debian 10
deb [arch=amd64] http://linphone.org/snapshots/debian buster stable # hotfix beta alpha
# For Debian 11
deb [arch=amd64] http://linphone.org/snapshots/debian bullseye stable # hotfix beta alpha
# For Debian 12
#deb [arch=amd64] http://linphone.org/snapshots/debian bookworm stable # hotfix beta alpha
\" >> /etc/apt/sources.list.d/belledonne.list

sleep 2
# For Debian
wget https://linphone.org/snapshots/debian/keyring.gpg -O - | sudo apt-key add -
sleep 2
#sudo apt -y install libmariadb-dev
#sleep 2
sudo apt -y update
sleep 2
sudo apt -y install bc-flexisip
sleep 2
sudo su 
/opt/belledonne-communications/bin/flexisip --dump-default all > /etc/flexisip/flexisip.conf
exit
sleep 2
sudo systemctl enable flexisip-proxy flexisip-presence
sleep 2
sudo systemctl start flexisip-proxy flexisip-presence
