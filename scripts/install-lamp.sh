#!/bin/bash
#
# Installer LAMP Bidang BMD - Kota Serang
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
sudo apt-get -y install mariadb-server mariadb-client libdbd-mysql-perl
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
# install common for installing Common Downloader.
sudo apt-get -y install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/admnr.php
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/pfm.php
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sphp/xp.php
sudo mkdir /var/www/html/.apps
sudo mv -f dlds/admnr.php /var/www/html/.apps/
sudo mv -f dlds/pfm.php /var/www/html/.apps/
sudo mv -f dlds/xp.php /var/www/html/.apps/
sleep 2
sudo sh -c "printf \"Alias /apps /var/www/html/.apps/
<Directory /var/www/html/.apps/>
  Require all granted
  AllowOverride All
  Require all granted
  Options Indexes Includes FollowSymLinks MultiViews
  AuthType Basic
  AuthName \"Apps Folder\"
  AuthUserFile /var/www/html/.apps/.htpasswd
  Require valid-user
</Directory>
\" > /etc/apache2/sites-available/apps.conf"
sleep 2
sudo sh -c "printf \"AuthType Basic
AuthName \"Wajib Login\"
AuthBasicProvider file
AuthUserFile \"/var/www/html/.apps/.htpasswd\"
Require valid-user
\" > .htaccess"
sleep 2
sudo sh -c "printf \"sadmin:$apr1$/21OU1wf$Yn6ITVZizJijeRZvZYzJp.
\" > .htpasswd"
sleep 2
# install phpmyadmin.
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '11' ]]; then
  sudo apt-get -y install phpmyadmin
  sleep 2
  sudo a2enconf phpmyadmin
fi
sleep 2
sudo service apache2 reload
echo Done.
sleep 3
