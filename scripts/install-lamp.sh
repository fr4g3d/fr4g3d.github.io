#!/bin/bash
#
# Installer LAMP Bidang BMD - Kota Serang
#
clear
#

# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install apache2 apache2-doc libapache2-mod-php libapache2-mod-fcgid openssl 
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
sudo apt-get -y install mariadb-server mariadb-client libdbd-mysql-perl
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin@123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset@123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user@123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > mysqld.sql"
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
# install common for installing Common Downloader.
sudo apt-get -y install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/admnr.php
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/pfm.php
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/xp.php
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv -f dlds/admnr.php /var/www/html/.apps/
sudo mv -f dlds/pfm.php /var/www/html/.apps/
sudo mv -f dlds/xp.php /var/www/html/.apps/
sleep 2
sudo rm dlds/adminer.zip
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/adminer.zip
unzip -o dlds/adminer.zip
sudo mv -f adminer/ /var/www/html/.apps/
sleep 2
sudo apt -y install adminer
sleep 2
sudo sh -c "printf \"Alias /adminer /etc/adminer

<Directory /etc/adminer>
        Require all granted
        AllowOverride All
        Options Indexes Includes FollowSymLinks MultiViews
        DirectoryIndex conf.php
</Directory>
\" > /etc/apache2/sites-available/adminer.conf"
sleep 2
sudo a2ensite adminer
sleep 2
sudo ln -s -f /usr/share/adminer/designs/rmsoft/adminer.css /etc/adminer/adminer.css
sleep 2
sudo service apache2 reload
sleep 2
sudo rm dlds/appz.zip
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/appz.zip
sleep 2
unzip -o dlds/appz.zip
sleep 2
sudo mv -f apps.conf /etc/apache2/sites-available/apps.conf
sudo cp -f .htaccess /var/www/html/.apps/.htaccess
sudo cp -f .htpasswd /var/www/html/.apps/.htpasswd
sudo cp -f .htaccess /etc/adminer/.htaccess
sudo cp -f .htpasswd /etc/adminer/.htpasswd
sudo mv -f .htaccess /var/www/html/.apps/adminer/.htaccess
sudo mv -f .htpasswd /var/www/html/.apps/adminer/.htpasswd
sleep 2
sudo a2ensite apps
sleep 2
# install phpmyadmin.
#VERSION=$(sed 's/\..*//' /etc/debian_version)
#if [[ $VERSION == '11' ]]; then
#  sudo apt-get -y install phpmyadmin
#  sleep 2
#  sudo a2enconf phpmyadmin
#fi
sleep 2
sudo service apache2 reload
echo Install [LAMP] is Done.
sleep 3
