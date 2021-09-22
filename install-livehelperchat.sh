#!/bin/bash
#
# Live Helper Chat Installer for DebX.
#
clear
#

sudo apt update
sudo apt install apache2 apache2-doc libapache2-mod-php openssl 
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
sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
sudo php -v
sleep 2
sudo apt install mariadb-server mariadb-client
sleep 2
sudo mysql_secure_installation
sleep 2
printf "CREATE DATABASE livehelperchat;\n" > lhcdb.sql
printf "CREATE USER 'livehelperchatuser'@'localhost' IDENTIFIED BY 'livehelperchatuser123';\n"  >> lhcdb.sql
printf "GRANT ALL PRIVILEGES ON livehelperchat.* TO 'livehelperchatuser'@'localhost';\n"  >> lhcdb.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> lhcdb.sql
printf "type root password and type input indide console:\n"
printf "like this >> \"source lhcdb.sql\"\n"
sleep 2
sudo mysql -u root -p
sleep 2
sudo apt install wget zip unzip
sleep 2
sudo rm dlds/master.z*
wget -P dlds/ https://github.com/remdex/livehelperchat/archive/master.zip
sleep 2
unzip dlds/master.zip
sleep 2
cd /var/www/html/
sudo mkdir .apps/
cd 
sudo mv livehelperchat-master/lhc_web/ /var/www/html/.apps/lhc/
sudo chown -R www-data:www-data /var/www/html/.apps/lhc/
sudo chmod -R 755 /var/www/html/.apps/lhc/
printf "Alias /lhc \"/var/www/html/.apps/lhc\"\n\n" > livehelperchat.conf
printf "<Directory /var/www/html/.apps/lhc>\n" >> livehelperchat.conf
printf "  Require all granted\n" >> livehelperchat.conf
printf "  AllowOverride All\n" >> livehelperchat.conf
printf "  Options FollowSymLinks MultiViews\n\n" >> livehelperchat.conf
printf "  <IfModule mod_dav.c>\n" >> livehelperchat.conf
printf "    Dav off\n" >> livehelperchat.conf
printf "  </IfModule>\n" >> livehelperchat.conf
printf "</Directory>\n\n" >> livehelperchat.conf
sudo cp livehelperchat.conf /etc/apache2/sites-available/
sudo a2ensite livehelperchat.conf
sleep 2
sudo service apache2 restart
sleep 3
echo Done.
