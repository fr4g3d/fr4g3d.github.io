#!/bin/bash
#
# Install LAMP Server.
#
clear
#
termux-change-repo
pkg update
pkg install openssl openssh wget git -y
#rm php_7.4.12_aarch64.deb
#rm php-apache_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php-apache_7.4.12_aarch64.deb
#dpkg -i php_7.4.12_aarch64.deb
#dpkg -i php-apache_7.4.12_aarch64.deb
apt --fix-missing --fix-broken install
pkg install php-apache php apache2 mariadb -y -f
wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
tar xzvf dokuwiki-stable.tgz
mkdir $PREFIX/share/apache2/default-site/htdocs/dw/
mv dokuwiki-*/* $PREFIX/share/apache2/default-site/htdocs/dw/
httpd &
mysqld &
printf "Done..."
