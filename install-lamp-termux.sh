#!/bin/bash
#
# Install LAMP Server.
#
clear
#
termux-change-repo
pkg update && pkg upgrade -y
pkg install openssl openssh wget git -y
#rm php_7.4.12_aarch64.deb
#rm php-apache_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php-apache_7.4.12_aarch64.deb
#dpkg -i php_7.4.12_aarch64.deb
#dpkg -i php-apache_7.4.12_aarch64.deb
apt --fix-missing --fix-broken install
pkg install php php-apache apache2 mariadb -y -f
rm dokuwiki-stable.tgz
wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
tar -xzvf dokuwiki-stable.tgz
mkdir $PREFIX/share/apache2/default-site/htdocs/dw/
mv dokuwiki-*/* $PREFIX/share/apache2/default-site/htdocs/dw/
cd $PREFIX/share/apache2/default-site/htdocs/
git clone https://github.com/gabrielecirulli/2048.git
cd
printf "LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so" >> $PREFIX/etc/apache2/httpd.conf
printf "LoadModule php_module libexec/apache2/libphp.so" >> $PREFIX/etc/apache2/httpd.conf
printf "<IfModule dir_module>" >> $PREFIX/etc/apache2/httpd.conf
printf "  DirectoryIndex index.html index.php" >> $PREFIX/etc/apache2/httpd.conf
printf "</IfModule>" >> $PREFIX/etc/apache2/httpd.conf
printf "</IfModule>" >> $PREFIX/etc/apache2/httpd.conf
printf "<FilesMatch \.php$>" >> $PREFIX/etc/apache2/httpd.conf
printf "    SetHandler application/x-httpd-php" >> $PREFIX/etc/apache2/httpd.conf
printf "</FilesMatch>" >> $PREFIX/etc/apache2/httpd.conf
httpd &
mysqld &
printf "Done..."
