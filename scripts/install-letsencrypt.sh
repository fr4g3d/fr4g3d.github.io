#!/bin/bash
#
# Let’s Encrypt Installer for DebX.
#
clear
#

sudo apt update
sleep 2
echo Install [Lets Encrypt] Start...
sleep 2
sudo apt-get -y install python3-certbot-apache
sleep 2
sudo certbot --apache
sleep 2
echo Install [Lets Encrypt] is Done.
sleep 3
