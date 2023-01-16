#!/bin/bash
#
# Live Helper Chat Installer for DebX.
#
clear
#

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
printf "CREATE DATABASE livehelperchat;\n" > lhcdb.sql
printf "CREATE USER 'livehelperchatuser'@'localhost' IDENTIFIED BY 'livehelperchatuser123';\n"  >> lhcdb.sql
printf "GRANT ALL PRIVILEGES ON livehelperchat.* TO 'livehelperchatuser'@'localhost';\n"  >> lhcdb.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> lhcdb.sql
sleep 2
sudo mysql -uroot < lhcdb.sql
sleep 2
# install common for installing Live Helper Chat.
sudo apt -y install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo rm -r livehelperchat-master/
sudo rm dlds/master.z*
#wget -P dlds/ https://github.com/remdex/livehelperchat/archive/master.zip
aria2c -d dlds/ -c -x 16 https://github.com/remdex/livehelperchat/archive/master.zip
sleep 2
unzip dlds/master.zip
sleep 2
sudo mkdir /var/www/html/.apps
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
sleep 2
echo Done.
sleep 3
