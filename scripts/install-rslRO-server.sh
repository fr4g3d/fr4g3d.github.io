#!/bin/bash
# Install Ragnarok Private Server
clear
#
# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
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
sudo apt-get -y install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-apcu php-redis php-imagick
sudo apt-get -y install redis-server php-redis php-apcu
#sudo apt-get install php php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-mysql php-bz2 php-intl php-ldap php-smbclient php-imap php-bcmath php-gmp php-redis php-imagick
#sudo apt-get -y install smbclient cifs-utils libsmbclient-dev php-dev make
#sudo pecl install smbclient
#sudo sh -c "printf 'extension=smbclient.so' >> /etc/php/7.4/fpm/php.ini"
#sudo systemctl restart php7.4-fpm
sudo php -v
sleep 2
sudo apt-get -y install git make gcc g++ zlib1g-dev libpcre3-dev mariadb-server mariadb-client libdbd-mysql-perl libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat
sleep 2
sudo apt-get -y install git make libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat gcc g++ zlib1g-dev libpcre3-dev
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/enable-fastcgi.sh)
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/install-phpmyadmin.sh)
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/install-rslRO-l2tp.sh)
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/rAthena-2018-10-10.zip
mkdir ~/rslRO/rAthena-20181010
sleep 2
unzip -o dlds/rAthena-2018-10-10.zip -d ~/rslRO/rAthena-20181010
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
sudo sh -c "printf \"CREATE DATABASE rslrodb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON rslrodb.* TO 'rslrouser'@'localhost' IDENTIFIED BY 'rslro@123';
FLUSH PRIVILEGES;
\"  > rslrodb.sql"
sleep 2
sudo mysql -uroot < rslrodb.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/main.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/logs.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_cash_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_cash_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/roulette_default_data.sql
sleep 2
cd ~/rslRO/rAthena-20181010
sleep 2
sudo chmod +x configure
./configure --enable-64bit --enable-packetver=20100831 --enable-prere=yes --with-MYSQL_LIBS=/usr/lib/x86_64-linux-gnu/libmariadbclient.so
make -C ~/rslRO/rAthena-20181010 clean && make -C ~/rslRO/rAthena-20181010 server
sleep 2
sudo chmod +x athena-start
sudo chmod +x *-server
sleep 2
echo Well Done..
sleep 1
echo Type: ./athena-start start 
echo to Start Server
sleep 2
./athena-start restart
sleep 1
cd
