#!/bin/bash
#
# Installer eMail Server.
#
clear
#

sudo apt update
sleep 2
# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
echo "Install [LAMP] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-lamp.sh)
echo "Install [FastCGi] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/enable-fastcgi.sh)
echo "Install [phpMyAdmin] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-phpmyadmin.sh)
sleep 2
clear
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'localhost' IDENTIFIED BY 'roundcube@123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'localhost' IDENTIFIED BY 'roundcube@123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > roundcube.sql"
printf "type \"source roundcube.sql\"\n"
sleep 2
sudo apt-get -y install roundcube
sleep 2
sudo mysql -uroot < roundcube.sql
sleep 2
# install eMail Server Apps.
sudo apt-get -y install postfix dovecot-pop3d dovecot-imapd bind9
sleep 2

echo Install [eMail-Server] is Done.
sleep 3
