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
sudo apt -y install dnsutils openssl openssh-server openssh-client shellinabox curl wget aria2 zip unzip
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/00_Green_On_Black.css
sudo mv dlds/00_Green_On_Black.css /etc/shellinabox/options-available/
sudo ln -s /etc/shellinabox/options-available/00_Green_On_Black.css /etc/shellinabox/options-enabled/00+Green_On_Black.css
sudo mv "/etc/shellinabox/options-enabled/00+Black on White.css" "/etc/shellinabox/options-enabled/00_Black On White.css"
sudo sh -c "printf \"SHELLINABOX_ARGS=\"--disable-ssl\"\n\" >> /etc/default/shellinabox"
sudo service shellinabox restart
sleep 2
aria2c -d dlds/ -c -x 16 https://github.com/nirui/sshwifty/releases/download/0.2.14-beta-release-prebuild/sshwifty_0.2.14-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
tar -xf dlds/sshwifty_0.2.14-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
mkdir .config/
cd sshwifty/
chmod +x sshwifty_linux_amd64
sudo install sshwifty_linux_amd64 /usr/local/bin/sshwifty
cp sshwifty.conf.example.json ~/.config/sshwifty.conf.json
cd 
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
sudo mv sshwifty.service /etc/systemd/system/sshwifty.service
sudo systemctl enable sshwifty.service
sudo service sshwifty start
sleep 3
# install apache2 mod-php openssl.
sudo apt update
sudo apt -y install apache2 apache2-doc libapache2-mod-php openssl 
#sudo apt install apache2 apache2-doc libapache2-mod-php openssl 
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo a2enmod rewrite
sudo a2enmod setenvif
sudo a2enmod ssl
sudo a2ensite default-ssl
sudo service apache2 reload
sleep 2
# install php php-commons.
sudo apt -y install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite* php-mysql* php-pgsql* php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
sudo apt -y install smbclient cifs-utils libsmbclient-dev php-dev make
sudo pecl install smbclient
sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt -y install mariadb-server mariadb-client
sleep 2
printf "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;\n" > mysqld.sql
printf "GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;\n" >> mysqld.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> mysqld.sql
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
# install common for installing Common Downloader.
sudo apt -y install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/pfm.php
aria2c -d dlds/ -c -x 16 https://fr4g3d.github.io/xp.php
sudo mkdir /var/www/html/.apps
sudo mv dlds/pfm.php /var/www/html/.apps/
sudo mv dlds/xp.php /var/www/html/.apps/
sleep 2
echo Done.
sleep 3
