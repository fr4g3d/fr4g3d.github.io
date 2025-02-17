#!/bin/bash
#
# Installer KVM/Qemu and Cockpit VM
#
clear
#

# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
# install FlexiSiP.
VERSION=NONE
if [ $(sed 's/\..*//' /etc/debian_version) == '9' ]; then
  VERSION=$(sed 's/\..*//' /etc/debian_version)
  sudo sh -c "printf \"deb [arch=amd64] http://linphone.org/snapshots/debian stretch stable # hotfix beta alpha\" > /etc/apt/sources.list.d/belledonne.list"
elif [ $(sed 's/\..*//' /etc/debian_version) == '10' ]; then
  VERSION=$(sed 's/\..*//' /etc/debian_version)
  sudo sh -c "printf \"deb [arch=amd64] http://linphone.org/snapshots/debian buster stable # hotfix beta alpha\" > /etc/apt/sources.list.d/belledonne.list"
elif [ $(sed 's/\..*//' /etc/debian_version) == '11' ]; then
  VERSION=$(sed 's/\..*//' /etc/debian_version)
  sudo sh -c "printf \"deb [arch=amd64] http://linphone.org/snapshots/debian bullseye stable # hotfix beta alpha\" > /etc/apt/sources.list.d/belledonne.list"
elif [ $(sed 's/\..*//' /etc/debian_version) == '12' ]; then
  VERSION=$(sed 's/\..*//' /etc/debian_version)
  sudo sh -c "printf \"deb [arch=amd64] http://linphone.org/snapshots/debian bookworm stable # hotfix beta alpha\" > /etc/apt/sources.list.d/belledonne.list"
fi
sleep 2
# Key-Ring For Debian
wget https://linphone.org/snapshots/debian/keyring.gpg -O - | sudo apt-key add -
sleep 2
#sudo apt-get -y install libmariadb-dev
#sleep 2
sudo apt-get -y update
sleep 2
sudo apt-get -y install bc-flexisip
sleep 2
/opt/belledonne-communications/bin/flexisip --dump-default all > flexisip.conf
sleep 2
sudo sh -c "printf \"
#
[global]
aliases=sip.example.org localhost

[presence-server]
long-term-enabled=true

[module::DoSProtection]
enabled=false

[module::Registrar]
enabled=true
reg-domains=sip.example.org localhost
db-implementation=internal

[module::Authentication]
enabled=true
auth-domains=sip.example.org localhost
db-implementation=file
file-path=/etc/flexisip/users.db.txt
#
\" >> flexisip.conf"
sleep 2
sudo sh -c "printf \"#
\" >> domain-registrations.conf"
sleep 2
sudo sh -c "printf \"version:1

admin@sip.example.org clrtxt:admin123 ;
user1@sip.example.org clrtxt:user1231 ;
user2@sip.example.org clrtxt:user1232 ;
user3@sip.example.org clrtxt:user1233 ;
\" >> users.db.txt"
sleep 2
# copy configs.
sudo cp flexisip.conf /etc/flexisip/flexisip.conf
sudo cp domain-registrations.conf /etc/flexisip/domain-registrations.conf
sudo cp users.db.txt /etc/flexisip/users.db.txt
sleep 2
# install IPTables
sudo apt-get -y install iptables
sleep 2
# First, create a specific chain for Flexisip rules.
sudo iptables -N flexisip-input-rules
# UDP/TCP on port 5060
sudo iptables -A flexisip-input-rules -p udp -m udp --dport 5060 -j ACCEPT
# TLS on port 5061
sudo iptables -A flexisip-input-rules -p tcp -m tcp --dport 5061 -j ACCEPT
# STUN on port 3478
sudo iptables -A flexisip-input-rules -p udp -m udp --dport 3478 -j ACCEPT
# RTP (if media relay is enabled)
sudo iptables -A flexisip-input-rules -p udp -m udp --dport 10000:20000 -j ACCEPT
# And then, add the new table into the INPUT chain
sudo iptables -A INPUT -j flexisip-input-rules
# inserting before the fourth rules
sudo iptables -I INPUT 4 -j flexisip-input-rules
sleep 2
sudo systemctl enable flexisip-proxy flexisip-presence
sleep 2
sudo systemctl start flexisip-proxy flexisip-presence
sleep 2
sudo systemctl status flexisip-proxy flexisip-presence
sleep 2
echo Done.
