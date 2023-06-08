#!/bin/bash
#
# Install LAMP Server.
#
clear
#
printf "Change Termux Repository...\n"
sleep 3
termux-change-repo
printf "Changed and Updated Repository...\n"
sleep 3
printf "Update and Upgrade Packages...\n"
sleep 3
pkg update && pkg upgrade -y
sleep 3
printf "Install OpenSSL, OpenSSH, WGet and GiT Packages...\n"
sleep 3
pkg install openssl openssh wget git -y
sleep 3
rm php_7.4.12_aarch64.deb
rm php-apache_7.4.12_aarch64.deb
wget https://fr4g3d.github.io/php_7.4.12_aarch64.deb
wget https://fr4g3d.github.io/php-apache_7.4.12_aarch64.deb
dpkg -i php_7.4.12_aarch64.deb
dpkg -i php-apache_7.4.12_aarch64.deb
sleep 3
printf "Install and Fix Missing and Broken Packages...\n"
sleep 3
apt --fix-missing --fix-broken install
sleep 3
printf "Install PHP, PHP-Apache, Apache2 and MariDB Packages...\n"
sleep 3
pkg install apache2 mariadb -y
#sleep 3
#pkg install php php-apache apache2 mariadb -y
sleep 3
printf "Download DokuWiki Package...\n"
sleep 3
rm dokuwiki-stable.tgz
wget https://fr4g3d.github.io/dokuwiki-2023-04-04a.tgz
sleep 3
printf "Extracting DokuWiki Package...\n"
sleep 3
tar -xzvf dokuwiki-2023-04-04a.tgz
sleep 3
printf "Moving DokuWiki Package...\n"
sleep 3
mkdir $PREFIX/share/apache2/default-site/htdocs/dw/
mv dokuwiki-*/* $PREFIX/share/apache2/default-site/htdocs/dw/
sleep 3
printf "Download 2048 Package...\n"
sleep 3
cd $PREFIX/share/apache2/default-site/htdocs/
git clone https://github.com/gabrielecirulli/2048.git
sleep 3
cd
printf "Setting Up httpd.conf and Enable Modules...\n"
sleep 3
wget https://fr4g3d.github.io/httpd-php.conf
cp httpd-php.conf $PREFIX/etc/apache2/httpd.conf
wget https://fr4g3d.github.io/index.html.crc
cp index.html.crc.html $PREFIX/share/apache2/default-site/htdocs/index.html
printf "<? phpinfo(); ?>\n" > $PREFIX/share/apache2/default-site/htdocs/index.php
sleep 3
printf "Starting httpd and mysqld Services...\n"
sleep 3

httpd &

sleep 3

mysqld &

sleep 3

printf "Well Done...\n"
sleep 1
printf "Please visit http://localhost:8080/...\n"
sleep 3
