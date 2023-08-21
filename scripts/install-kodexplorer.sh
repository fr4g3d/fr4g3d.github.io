#!/bin/bash
#
# Nextcloud v.21.0.4 Installer for ncmbd-debx Server.
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
sudo apt -y install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt -y install mariadb-server mariadb-client
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\"  > mysqld.sql"
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
sudo sh -c "printf \"CREATE DATABASE kodexplorer;
CREATE USER 'kodexplorer'@'localhost' IDENTIFIED BY 'kodexplorer123';
GRANT ALL PRIVILEGES ON kodexplorer.* TO 'kodexplorer'@'localhost';
FLUSH PRIVILEGES;
\"  > kodedb.sql"
printf "type \"source kodedb.sql\"\n"
sleep 2
sudo mysql -uroot < kodedb.sql
sleep 2
# install common for installing Nextcloud.
sudo apt -y install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo rm -r KodExplorer/
sudo rm dlds/KodExplorer.zip
#wget -P dlds/ https://fr4g3d.github.io/sarch/KodExplorer.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/KodExplorer.zip
sleep 2
unzip dlds/KodExplorer.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv -f KodExplorer/ /var/www/html/.apps/
sudo chown -R www-data:www-data /var/www/html/.apps/KodExplorer/
sudo chmod -R 755 /var/www/html/.apps/KodExplorer/
sudo sh -c "printf \"Alias /kode \"/var/www/html/.apps/KodExplorer/\"
<Directory /var/www/html/.apps/KodExplorer/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
\" > KodExplorer.conf"
sudo cp KodExplorer.conf /etc/apache2/sites-available/
sudo a2ensite KodExplorer.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Done.
sleep 3
