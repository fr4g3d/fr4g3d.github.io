#!/bin/bash
#
# Install LAMP Server.
#
clear
#
printf "Change Termux Repository..."
sleep 3
termux-change-repo
printf "Changed and Updated Repository..."
sleep 3
printf "Update and Upgrade Packages..."
sleep 3
pkg update && pkg upgrade -y
sleep 3
printf "Install OpenSSL, OpenSSH, WGet and GiT Packages..."
sleep 3
pkg install openssl openssh wget git -y
sleep 3
#rm php_7.4.12_aarch64.deb
#rm php-apache_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php_7.4.12_aarch64.deb
#wget https://github.com/Termux-pod/termux-pod/raw/main/aarch64/Php7/php-apache_7.4.12_aarch64.deb
#dpkg -i php_7.4.12_aarch64.deb
#dpkg -i php-apache_7.4.12_aarch64.deb
printf "Install and Fix Missing and Broken Packages..."
sleep 3
apt --fix-missing --fix-broken install
sleep 3
printf "Install PHP, PHP-Apache, Apache2 and MariDB Packages..."
sleep 3
pkg install php php-apache apache2 mariadb -y
sleep 3
printf "Download DokuWiki Package..."
sleep 3
rm dokuwiki-stable.tgz
wget https://fr4g3d.github.io/dokuwiki-2023-04-04a.tgz
sleep 3
printf "Extracting DokuWiki Package..."
sleep 3
tar -xzvf dokuwiki-2023-04-04a.tgz
sleep 3
printf "Moving DokuWiki Package..."
sleep 3
mkdir $PREFIX/share/apache2/default-site/htdocs/dw/
mv dokuwiki-*/* $PREFIX/share/apache2/default-site/htdocs/dw/
sleep 3
printf "Download 2048 Package..."
sleep 3
cd $PREFIX/share/apache2/default-site/htdocs/
git clone https://github.com/gabrielecirulli/2048.git
sleep 3
cd
printf "Setting Up httpd.conf and Enable Modules..."
sleep 3
printf "LoadModule mpm_worker_module libexec/apache2/mod_mpm_worker.so\n" >> $PREFIX/etc/apache2/httpd.conf
printf "LoadModule php_module libexec/apache2/libphp.so\n" >> $PREFIX/etc/apache2/httpd.conf
printf "<IfModule dir_module>\n" >> $PREFIX/etc/apache2/httpd.conf
printf "  DirectoryIndex index.html index.php\n" >> $PREFIX/etc/apache2/httpd.conf
printf "</IfModule>\n" >> $PREFIX/etc/apache2/httpd.conf
printf "</IfModule>\n" >> $PREFIX/etc/apache2/httpd.conf
printf "<FilesMatch \.php$>\n" >> $PREFIX/etc/apache2/httpd.conf
printf "    SetHandler application/x-httpd-php\n" >> $PREFIX/etc/apache2/httpd.conf
printf "</FilesMatch>\n" >> $PREFIX/etc/apache2/httpd.conf
sleep 3
printf "Starting httpd and mysqld Services..."
sleep 3

httpd &

sleep 3

mysqld &

sleep 3

printf "Well Done..."
sleep 3
printf "Please visit http://localhost:8080/..."
sleep 3