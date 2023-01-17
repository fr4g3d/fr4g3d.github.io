#!/bin/bash
#
# Installer Common Apps for (Pre)Nextcloud Bidang BMD - Kota Serang
#
clear
#

# disabling ipv6
sudo sh -c "printf \"\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.all.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.default.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.lo.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo sh -c "printf \"net.ipv6.conf.tun0.disable_ipv6 = 1\n\" >> /etc/sysctl.conf"
sudo service networking reload

# install common apps.
sudo apt update
sleep 2
sudo apt-ml install curl wget aria2 unzip

aria2c -d dlds/ -c -x8 https://raw.githubusercontent.com/tatsuhiro-t/apt-metalink/master/apt-metalink
sudo chmod +x dlds/apt-metalink
sudo install dlds/apt-metalink /usr/local/bin/apt-ml
sleep 2
sudo apt-ml install dnsutils openssl openssh-server openssh-client shellinabox curl wget aria2 zip unzip
aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/00_Green_On_Black.css
sudo mv dlds/00_Green_On_Black.css /etc/shellinabox/options-available/
sudo ln -s /etc/shellinabox/options-available/00_Green_On_Black.css /etc/shellinabox/options-enabled/00+Green_On_Black.css
sudo mv "/etc/shellinabox/options-enabled/00+Black on White.css" "/etc/shellinabox/options-enabled/00_Black On White.css"
sudo sh -c "printf \"SHELLINABOX_ARGS=\"--disable-ssl\"\n\" >> /etc/default/shellinabox"
sudo service shellinabox restart
sleep 2
sudo rm dlds/sshwifty_0.2.*.tar.gz
aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz
mkdir sshwifty/
sudo tar -xf dlds/sshwifty_0.2.22-beta-release_linux_amd64.tar.gz -C ~/sshwifty/
sleep 2
mkdir .config/
chmod +x sshwifty/sshwifty_linux_amd64
sudo install sshwifty/sshwifty_linux_amd64 /usr/local/bin/sshwifty
aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/sshwifty.conf.json
sleep 2
sudo cp dlds/sshwifty.conf.json ~/.config/
printf "[Unit]\n" > sshwifty.service
printf "Description=SSH Wifty Service.\n" >> sshwifty.service
printf "After=network.target\n" >> sshwifty.service
printf "StartLimitIntervalSec=0\n" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Service]\n" >> sshwifty.service
printf "Type=simple\n" >> sshwifty.service
printf "Restart=always\n" >> sshwifty.service
printf "RestartSec=1\n" >> sshwifty.service
printf "User=aset\n" >> sshwifty.service
printf "ExecStart=/usr/local/bin/sshwifty\n" >> sshwifty.service
printf "\n" >> sshwifty.service
printf "[Install]\n" >> sshwifty.service
printf "WantedBy=multi-user.target\n" >> sshwifty.service
printf "\n" >> sshwifty.service
sleep 2
sudo mv sshwifty.service /etc/systemd/system/sshwifty.service
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-pdo php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
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
printf "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;\n" > mysqld.sql
printf "GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;\n" >> mysqld.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> mysqld.sql
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
# install common for installing Common Downloader.
sudo apt-ml install curl wget zip unzip aria2 ffmpeg
sleep 2
aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/pfm.php
aria2c -d dlds/ -c -x8 https://fr4g3d.github.io/xp.php
sudo mkdir /var/www/html/.apps
sudo mv dlds/pfm.php /var/www/html/.apps/
sudo mv dlds/xp.php /var/www/html/.apps/
sleep 2
sudo apt install phpmyadmin
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-pdo php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
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
printf "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123' WITH GRANT OPTION;\n" > mysqld.sql
printf "GRANT ALL PRIVILEGES ON *.* TO 'aset'@'localhost' IDENTIFIED BY 'aset123' WITH GRANT OPTION;\n" >> mysqld.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> mysqld.sql
printf "type \"source mysqld.sql\"\n"
sleep 2
sudo mysql -uroot < mysqld.sql
sleep 2
printf "CREATE DATABASE livehelperchat;\n" > lhcdb.sql
printf "CREATE USER 'livehelperchatuser'@'localhost' IDENTIFIED BY 'livehelperchatuser123';\n"  >> lhcdb.sql
printf "GRANT ALL PRIVILEGES ON livehelperchat.* TO 'livehelperchatuser'@'localhost';\n"  >> lhcdb.sql
printf "FLUSH PRIVILEGES;\n\\q"  >> lhcdb.sql
sleep 2
sudo mysql -uroot < lhcdb.sql
sleep 2
# install common for installing Live Helper Chat.
sudo apt-ml install curl wget zip unzip aria2
sleep 2
sudo rm -r livehelperchat-master/
sudo rm dlds/livehelperchat-master*.z*
#wget -P dlds/ https://github.com/remdex/livehelperchat/archive/master.zip
aria2c -d dlds/ -c -x8 https://github.com/remdex/livehelperchat/archive/master.zip
sleep 2
unzip dlds/livehelperchat-master.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv livehelperchat-master/lhc_web/ /var/www/html/.apps/lhc/
sudo chown -R www-data:www-data /var/www/html/.apps/lhc/
sudo chmod -R 755 /var/www/html/.apps/lhc/
printf "Alias /lhc \"/var/www/html/.apps/lhc\"\n\n" > livehelperchat.conf
printf "<Directory /var/www/html/.apps/lhc>\n" >> livehelperchat.conf
printf "  Require all granted\n" >> livehelperchat.conf
printf "  AllowOverride All\n" >> livehelperchat.conf
printf "  Options FollowSymLinks MultiViews\n\n" >> livehelperchat.conf
printf "  <IfModule mod_dav.c>\n" >> livehelperchat.conf
printf "    Dav off\n" >> livehelperchat.conf
printf "  </IfModule>\n" >> livehelperchat.conf
printf "</Directory>\n\n" >> livehelperchat.conf
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
sudo apt-ml install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-pdo php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-redis php-imagick
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
sudo apt-ml install curl wget zip unzip aria2 ffmpeg
sleep 2
sudo rm -r nextcloud/
sudo rm dlds/latest-2*.zip
#wget -P dlds/ https://download.nextcloud.com/server/releases/latest-25.zip
aria2c -d dlds/ -c -x8 https://download.nextcloud.com/server/releases/latest-25.zip
sleep 2
unzip dlds/latest-25.zip
sleep 2
sudo mkdir /var/www/html/.apps
sudo mv nextcloud/ /var/www/html/.apps/
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
