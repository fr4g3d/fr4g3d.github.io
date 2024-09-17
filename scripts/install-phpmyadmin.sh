#!/bin/bash
#
# phpMyAdmin Installer for DebX.
#
clear
#

sudo apt update
sleep 2
sudo sh -c "printf \"CREATE DATABASE phpmyadmin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON phpmyadmin.* TO 'phpmyadmin'@'localhost' IDENTIFIED BY 'phpmyadmin@123';
FLUSH PRIVILEGES;
\"  > pmadb.sql"
sleep 2
sudo mysql -uroot < pmadb.sql
sleep 2
# install common apps and Downloader.
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
sudo rm -r phpMyAdmin-5.1.3-all-languages/
sudo rm dlds/phpMyAdmin-5.1.3-all-languages.z*
sudo rm -r boodark/
#wget -P dlds/ https://files.phpmyadmin.net/phpMyAdmin/5.1.3/phpMyAdmin-5.1.3-all-languages.zip
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/phpMyAdmin-5.1.3-all-languages.zip
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/boodark-1.0.1.zip
sleep 2
unzip dlds/phpMyAdmin-5.1.3-all-languages.zip
sleep 2
unzip dlds/boodark-1.0.1.zip
sudo mv -f phpMyAdmin-5.1.3-all-languages/ /usr/share/
sleep 2
sudo mv -f boodark/ /usr/share/phpMyAdmin-5.1.3-all-languages/themes/
sudo chown -R www-data:www-data /usr/share/phpMyAdmin-5.1.3-all-languages/
sudo chmod -R 755 /usr/share/phpMyAdmin-5.1.3-all-languages/
sudo rm dlds/appz.zip
aria2c -d dlds -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/appz.zip
unzip -o dlds/appz.zip
sudo cp -f .htaccess /usr/share/phpMyAdmin-5.1.3-all-languages/.htaccess
sudo cp -f .htpasswd /usr/share/phpMyAdmin-5.1.3-all-languages/.htpasswd
sleep 2
sudo sh -c "printf \"Alias /pmadmin \"/usr/share/phpMyAdmin-5.1.3-all-languages\"
<Directory /usr/share/phpMyAdmin-5.1.3-all-languages/>
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
