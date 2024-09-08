#!/bin/bash
#
# phpMyAdmin Installer for DebX.
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
sudo sh -c "printf \"CREATE DATABASE phpmyadmin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON phpmyadmin.* TO 'phpmyadmin'@'localhost' IDENTIFIED BY 'phpmyadmin@123';
FLUSH PRIVILEGES;
\"  > pmadb.sql"
sleep 2
sudo mysql -uroot < pmadb.sql
sleep 2
# install common for installing Live Helper Chat.
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
sudo rm -r phpMyAdmin-5.1.2-all-languages/
sudo rm dlds/phpMyAdmin-5.1.2-all-languages.z*
#wget -P dlds/ https://files.phpmyadmin.net/phpMyAdmin/5.1.2/phpMyAdmin-5.1.2-all-languages.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/phpMyAdmin-5.1.2-all-languages.zip
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/boodark-1.0.1.zip
sleep 2
unzip dlds/phpMyAdmin-5.1.2-all-languages.zip
sleep 2
unzip dlds/boodark-1.0.1.zip
sudo mv -f phpMyAdmin-5.1.2-all-languages/ /usr/share/
sleep 2
sudo mv -f boodark/ /usr/share/phpMyAdmin-5.1.2-all-languages/themes/
sudo chown -R www-data:www-data /usr/share/phpMyAdmin-5.1.2-all-languages/
sudo chmod -R 755 /usr/share/phpMyAdmin-5.1.2-all-languages/
sudo sh -c "printf \"sadmin:$apr1$/21OU1wf$Yn6ITVZizJijeRZvZYzJp.
\" > /usr/share/phpMyAdmin-5.1.2-all-languages/.htpasswd"
sudo sh -c "printf \"AuthType Basic
AuthName \"Wajib Login\"
AuthBasicProvider file
AuthUserFile \"/var/www/html/.apps/.htpasswd\"
Require valid-user
\" > /usr/share/phpMyAdmin-5.1.2-all-languages/.htaccess"
sudo sh -c "printf \"Alias /pmadmin \"/usr/share/phpMyAdmin-5.1.2-all-languages\"
<Directory /usr/share/phpMyAdmin-5.1.2-all-languages/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
\" > phpmyadmin.conf"
sudo cp phpmyadmin.conf /etc/apache2/sites-available/
sudo a2ensite phpmyadmin.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Install [phpMyAdmin] is Done.
sleep 3
