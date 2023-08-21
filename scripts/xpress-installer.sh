#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
sudo sh -c "printf \"
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.tun0.disable_ipv6 = 1
\" >> /etc/sysctl.conf"
sudo service networking reload

# install common apps.
sudo apt update
sleep 2
sudo apt-ml install curl wget aria2 unzip

sudo aria2c -d dlds/ -c -x8 https://raw.githubusercontent.com/tatsuhiro-t/apt-metalink/master/apt-metalink
sudo chmod +x dlds/apt-metalink
sudo install dlds/apt-metalink /usr/local/bin/apt-ml
sleep 2
sudo apt-ml install dnsutils openssl openssh-server openssh-client shellinabox curl wget aria2 zip unzip
sudo aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/scss/00_Green_On_Black.css
sudo mv dlds/00_Green_On_Black.css /etc/shellinabox/options-available/
sudo ln -s /etc/shellinabox/options-available/00_Green_On_Black.css /etc/shellinabox/options-enabled/00+Green_On_Black.css
sudo mv "/etc/shellinabox/options-enabled/00+Black on White.css" "/etc/shellinabox/options-enabled/00_Black On White.css"
sudo sh -c "printf \"SHELLINABOX_ARGS=\"--disable-ssl\"\n\" >> /etc/default/shellinabox"
sudo service shellinabox restart
sleep 2
sudo rm dlds/sshwifty_0.2.*.tar.gz
sudo aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sarch/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
sudo tar -xf dlds/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
sleep 2
mkdir .config/
chmod +x sshwifty/sshwifty_linux_amd64
sudo install sshwifty/sshwifty_linux_amd64 /usr/local/bin/sshwifty
sudo aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sconf/sshwifty.conf.json
sleep 2
sudo cp dlds/sshwifty.conf.json ~/.config/
sudo sh -c "printf \"[Unit]
Description=SSH Wifty Service.
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
Group=root
ExecStart=/usr/local/bin/sshwifty

[Install]
WantedBy=multi-user.target
\" > /etc/systemd/system/sshwifty.service"
sleep 2
sudo systemctl enable sshwifty.service
sleep 2
sudo service sshwifty start
sleep 2
sudo service sshwifty restart
sleep 2
echo Done.
#
# Installer LAMP Bidang BMD - Kota Serang
#
clear
#

# install apache2 mod-php openssl.
sudo apt update
sudo apt-ml install apache2 apache2-doc libapache2-mod-php openssl 
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt-ml install mariadb-server mariadb-client
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > mysqld.sql"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
# install common for installing Common Downloader.
sudo apt-ml install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sphp/pfm.php
sudo aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sphp/xp.php
sudo mkdir /var/www/html/.apps
sudo mv dlds/pfm.php /var/www/html/.apps/
sudo mv dlds/xp.php /var/www/html/.apps/
sleep 2
sudo apt-ml install phpmyadmin
sleep 2
sudo a2enconf phpmyadmin
sleep 2
sudo service apache2 reload
echo Done.
sleep 3
#
# Live Helper Chat Installer for DebX.
#
clear
#

# install apache2 mod-php openssl.
sudo apt update
sudo apt-ml install apache2 apache2-doc libapache2-mod-php openssl 
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt-ml install mariadb-server mariadb-client
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > mysqld.sql"
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
sudo apt-ml install curl wget zip unzip aria2
sleep 2
sudo rm -r livehelperchat-master/
sudo rm dlds/livehelperchat-master*.z*
#wget -P dlds/ https://github.com/remdex/livehelperchat/archive/master.zip
sudo aria2c -d dlds/ -c -x8 https://github.com/remdex/livehelperchat/archive/master.zip
sleep 2
unzip dlds/livehelperchat-master.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv livehelperchat-master/lhc_web/ /var/www/html/.apps/lhc/
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
#
# Nextcloud v.21.0.4 Installer for ncmbd-debx Server.
#
clear
#

# install apache2 mod-php openssl.
sudo apt update
sudo apt-ml install apache2 apache2-doc libapache2-mod-php openssl 
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
# install mariadb-server as mysql-server.
sudo apt-ml install mariadb-server mariadb-client
sleep 2
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > mysqld.sql"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
sudo sh -c "printf \"CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud123';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
\"  > ncdb.sql"
sleep 2
sudo mysql -uroot < ncdb.sql
sleep 2
# install common for installing Nextcloud.
sudo apt-ml install curl wget zip unzip aria2 ffmpeg
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
unzip dlds/$NCVer
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv nextcloud/ /var/www/html/.apps/
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
