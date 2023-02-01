#!/bin/bash
#
# Installer LAMP Bidang BMD - Kota Serang
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
# install common for installing Common Downloader.
sudo apt -y install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/admnr.php
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/pfm.php
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/xp.php
sudo mkdir /var/www/html/.apps
sudo mv dlds/admnr.php /var/www/html/.apps/
sudo mv dlds/pfm.php /var/www/html/.apps/
sudo mv dlds/xp.php /var/www/html/.apps/
sleep 2
#sudo apt -y install phpmyadmin
#sleep 2
#sudo a2enconf phpmyadmin
#sleep 2
sudo service apache2 reload
echo Done.
sleep 3
