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
# deb [arch=amd64] http://linphone.org/snapshots/debian buster stable # hotfix beta alpha
# For Debian 11
deb [arch=amd64] http://linphone.org/snapshots/debian bullseye stable # hotfix beta alpha
# For Debian 12
#deb [arch=amd64] http://linphone.org/snapshots/debian bookworm stable # hotfix beta alpha
\" >> /etc/apt/sources.list.d/belledonne.list"

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
/opt/belledonne-communications/bin/flexisip --dump-default all > flexisip.conf
sleep 2
sudo sh -c "printf \"#
[global]
debug=false
aliases=sip.example.org localhost

[module::Registrar]
enabled=true
reg-domains=sip.example.org localhost
db-implementation=internal

[module::Authentication]
enabled=true
auth-domains=sip.example.org localhost
db-implementation=file
file-path=/etc/flexisip/users.db.txt
\" >> flexisip.conf"
sleep 2
sudo sh -c "printf \"#
\" >> domain-registrations.conf"
sleep 2
sudo sh -c "printf \"#
version:1

admin@sip.example.org clrtxt:admin@123 ;
user1@sip.example.org clrtxt:user1@123 ;
\" >> users.db.txt"
sleep 2
# copy configs.
sudo cp flexisip.conf /etc/flexisip/flexisip.conf
sudo cp domain-registrations.conf /etc/flexisip/domain-registrations.conf
sudo cp users.db.txt /etc/flexisip/users.db.txt
sleep 2
# install IPTables
sudo apt -y install iptables
# Zero-FlexiSiP RuleZ
sudo iptables -w -V > /dev/null 2>&1
sudo iptables -F FLEXISIP 2>&1
sudo ip6tables -F FLEXISIP 2>&1
sudo iptables -t filter -A INPUT -j FLEXISIP 2>&1
sudo ip6tables -t filter -A INPUT -j FLEXISIP 2>&1
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
