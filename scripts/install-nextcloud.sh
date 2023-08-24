#!/bin/bash
#
# Nextcloud v.21.0.4 Installer for ncmbd-debx Server.
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
sudo a2enconf apache2-doc
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
sudo sh -c "printf \"CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud123';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
\"  > ncdb.sql"
printf "type \"source ncdb.sql\"\n"
sleep 2
sudo mysql -uroot < ncdb.sql
sleep 2
# install common for installing Nextcloud.
sudo apt-get -y install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo rm -r nextcloud/
sudo rm dlds/latest-2*.zip
sleep 1
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '9' ]]; then
  NCVer="latest-21.tar.bz2"
elif [[ $VERSION == '10' ]]; then
  NCVer="latest-23.tar.bz2"
elif [[ $VERSION == '11' ]]; then
  NCVer="latest-25.tar.bz2"
fi
echo $NCVer;
sleep 1
#wget -P dlds/ https://download.nextcloud.com/server/releases/latest-23.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://download.nextcloud.com/server/releases/$NCVer
sleep 2
tar -xjf dlds/$NCVer
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv -f nextcloud/ /var/www/html/.apps/
sudo chown -R www-data:www-data /var/www/html/.apps/nextcloud/
sudo chmod -R 755 /var/www/html/.apps/nextcloud/
sudo sh -c "printf \"Alias /nc \"/var/www/html/.apps/nextcloud/\"
<Directory /var/www/html/.apps/nextcloud/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
\" > nextcloud.conf"
sudo cp nextcloud.conf /etc/apache2/sites-available/
sudo a2ensite nextcloud.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Done.
sleep 3
