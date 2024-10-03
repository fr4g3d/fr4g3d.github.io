#!/bin/bash
#
# Nextcloud v.21.0.4 Installer for ncmbd-debx Server.
#
clear
#

# install apache2 mod-php openssl.
sudo apt-get update
sleep 2
sudo sh -c "printf \"CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud@123';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
\"  > ncdb.sql"
printf "type \"source ncdb.sql\"\n"
sleep 2
sudo mysql -uroot < ncdb.sql
sleep 2
# install common apps and Downloader + NextCloud.
sudo apt-get -y install git make gcc g++ zlib1g-dev libpcre3-dev mariadb-server mariadb-client libdbd-mysql-perl libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat
sleep 2
clear
sleep 1
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION == '9' ]]; then
  NCFVer="nxc-l21"
  NCVer="latest-21"
  NCConf="nxcbmd10"
elif [[ $VERSION == '10' ]]; then
  NCFVer="nxc-l23"
  NCVer="latest-23"
  NCConf="nxcbmd10"
elif [[ $VERSION == '11' ]]; then
  NCFVer="nxc-l25"
  NCVer="latest-25"
  NCConf="nxcbmd11"
fi
echo $NCVer.zip;
sleep 1
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.zip
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.z01
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.z02
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.z03
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.z04
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/$NCFVer/$NCVer.z05
sleep 2
sudo mkdir /var/www/.nc
zip -F dlds/$NCVer.zip --out dlds/nc-$NCVer.zip
sudo -u www-data unzip -o dlds/nc-$NCVer.zip -d /var/www/.nc
clear
sleep 2
sudo chown -R www-data:www-data /var/www/.nc/
sudo chmod -R 755 /var/www/.nc/
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sconf/$NCConf.conf
sudo sh -c "printf \"Alias /nc \"/var/www/.nc/\"
<Directory /var/www/.nc/>
  Require all granted
  AllowOverride All
  Options FollowSymLinks MultiViews
  <IfModule mod_dav.c>
    Dav off
  </IfModule>
</Directory>
\" > nextcloud.conf"
sudo cp nextcloud.conf /etc/apache2/sites-available/
sudo cp dlds/$NCConf.conf /etc/apache2/sites-available/nxcbmd.lan.conf
sudo a2ensite nextcloud.conf
sudo a2ensite nxcbmd.lan.conf
sleep 2
sudo service apache2 restart
sleep 2
echo Install [NextCloud] is Done.
sleep 3
