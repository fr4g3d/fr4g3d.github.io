#!/bin/bash
#
# Live Helper Chat Installer for DebX.
#
clear
#

# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install apache2 apache2-doc libapache2-mod-php openssl 
#sudo apt-get install apache2 apache2-doc libapache2-mod-php openssl 
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
sudo apt-get -y install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt-get install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt-get -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt-get -y install mariadb-server mariadb-client
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > mysqld.sql"
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
sudo sh -c "printf \"CREATE DATABASE livehelperchat;
CREATE USER 'livehelperchat'@'localhost' IDENTIFIED BY 'livehelperchat123';
GRANT ALL PRIVILEGES ON livehelperchat.* TO 'livehelperchat'@'localhost';
FLUSH PRIVILEGES;
\"  > lhcdb.sql"
sleep 2
sudo mysql -uroot < lhcdb.sql
sleep 2
# install common for installing Live Helper Chat.
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
sudo rm -r livehelperchat-master/
sudo rm dlds/livehelperchat-master*.z*
#wget -P dlds/ https://github.com/remdex/livehelperchat/archive/master.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://github.com/remdex/livehelperchat/archive/master.zip
sleep 2
unzip dlds/livehelperchat-master.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv -f livehelperchat-master/lhc_web/ /var/www/html/.apps/lhc/
sudo chown -R www-data:www-data /var/www/html/.apps/lhc/
sudo chmod -R 755 /var/www/html/.apps/lhc/
sudo sh -c "printf \"Alias /lhc \"/var/www/html/.apps/lhc\"
<Directory /var/www/html/.apps/lhc>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
\" > livehelperchat.conf"
sudo cp livehelperchat.conf /etc/apache2/sites-available/
sudo a2ensite livehelperchat.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Done.
sleep 3
