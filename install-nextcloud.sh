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
printf "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;\n" > mysqld.sql
printf "GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;\n" >> mysqld.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> mysqld.sql
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
printf "CREATE DATABASE nextcloud;\n" > ncdb.sql
printf "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud123';\n"  >> ncdb.sql
printf "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';\n"  >> ncdb.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> ncdb.sql
sleep 2
sudo mysql -uroot < ncdb.sql
sleep 2
# install common for installing Nextcloud.
sudo apt -y install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo rm -r nextcloud/
sudo rm dlds/latest-2*.zip
sleep 1
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '10' ]]; then
  NCVer="latest-23.zip"
elif [[ $VERSION == '11' ]]; then
  NCVer="latest-25.zip"
fi
echo $NCVer;
sleep 1
#wget -P dlds/ https://download.nextcloud.com/server/releases/latest-23.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://download.nextcloud.com/server/releases/$NCVer
sleep 2
unzip dlds/latest-23.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv -f nextcloud/ /var/www/html/.apps/
sudo chown -R www-data:www-data /var/www/html/.apps/nextcloud/
sudo chmod -R 755 /var/www/html/.apps/nextcloud/
printf "Alias /nc \"/var/www/html/.apps/nextcloud/\"\n\n" > nextcloud.conf
printf "<Directory /var/www/html/.apps/nextcloud/>\n" >> nextcloud.conf
printf "  Require all granted\n" >> nextcloud.conf
printf "  AllowOverride All\n" >> nextcloud.conf
printf "  Options FollowSymLinks MultiViews\n\n" >> nextcloud.conf
printf "  <IfModule mod_dav.c>\n" >> nextcloud.conf
printf "    Dav off\n" >> nextcloud.conf
printf "  </IfModule>\n" >> nextcloud.conf
printf "</Directory>\n\n" >> nextcloud.conf
sudo cp nextcloud.conf /etc/apache2/sites-available/
sudo a2ensite nextcloud.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Done.
sleep 3
