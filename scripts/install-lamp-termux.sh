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
printf "Install OpenSSL, OpenSSH, WGet and GiT Packages...\n\n"
sleep 3
pkg install openssl openssh wget git -y
sleep 3
#rm php_7.4.12_aarch64.deb
#rm php-apache_7.4.12_aarch64.deb
#wget https://fr4g3d.github.io/sdeb/php_7.4.12_aarch64.deb
#wget https://fr4g3d.github.io/sdeb/php-apache_7.4.12_aarch64.deb
#dpkg -i php_7.4.12_aarch64.deb
#dpkg -i php-apache_7.4.12_aarch64.deb
#sleep 3
sleep 3
printf "Install and Fix Missing and Broken Packages...\n\n"
sleep 3
apt-get --fix-missing --fix-broken install
sleep 3
printf "Install PHP, PHP-Apache, Apache2 and MariaDB Packages...\n\n"
#sleep 3
#pkg install apache2 mariadb -y
sleep 3
pkg install php php-apache apache2 mariadb -y
sleep 3
printf "\nDownload AjaxCMS Package...\n"
sleep 3
rm ajax_cms.zip
wget https://fr4g3d.github.io/sarch/ajax_cms.zip
sleep 3
printf "\nExtracting AjaxCMS Package...\n"
sleep 3
unzip ajax_cms.zip
rm ajax_cms.zip
sleep 3
printf "\nMoving AjaxCMS Package...\n"
sleep 3
mkdir $PREFIX/share/apache2/default-site/htdocs/ac/
sleep 1
mv -f ajax_cms/* $PREFIX/share/apache2/default-site/htdocs/ac/
sleep 1
rm -f -r ajax_cms/
sleep 3
printf "\nSuccess: AjaxCMS Installed...\n"
sleep 3
printf "\nDownload X-Pober Package...\n"
sleep 3
rm xprober.zip
wget https://fr4g3d.github.io/sarch/xprober.zip
sleep 3
printf "\nExtracting X-Pober Package...\n"
sleep 3
rm -f -r xprober.php
unzip xprober.zip
rm xprober.zip
sleep 3
printf "\nMoving X-Pober Package...\n"
sleep 3
mkdir $PREFIX/share/apache2/default-site/htdocs/xp/
sleep 1
mv -f xprober.php $PREFIX/share/apache2/default-site/htdocs/xp/index.php
sleep 1
rm -f -r xprober.php
sleep 3
printf "\nSuccess: X-Pober Installed...\n"
sleep 3
printf "\nDownload 2048 Game Package...\n"
sleep 3
wget https://fr4g3d.github.io/sarch/2048-master.zip
sleep 3
printf "\nExtracting 2048 Game Package...\n"
sleep 3
unzip 2048-master.zip
rm 2048-master.zip
sleep 3
printf "\nMoving 2048 Game Package...\n"
sleep 3
mkdir $PREFIX/share/apache2/default-site/htdocs/2048/
sleep 1
mv -f 2048-master/* $PREFIX/share/apache2/default-site/htdocs/2048/
sleep 1
rm -f -r 2048-master/
sleep 3
printf "\nSuccess: 2048 Game Installed...\n"
sleep 3
printf "\nSetting Up httpd.conf and Enable Modules...\n"
sleep 3
wget https://fr4g3d.github.io/sconf/httpd-php.conf
mv -f httpd-php.conf $PREFIX/etc/apache2/httpd.conf
wget https://fr4g3d.github.io/sphp/index.html.crc.html
mv -f index.html.crc.html $PREFIX/share/apache2/default-site/htdocs/index.html
printf "<? phpinfo(); ?>\n" > $PREFIX/share/apache2/default-site/htdocs/index.php
sleep 3
printf "\nStarting httpd and mysqld Services...\n\n"
sleep 3
username=$(whoami)
ipaddress=$(2>/dev/null ifconfig | grep inet | tail -1 | awk '{printf $2}')
sleep 1
printf "UserName : %s \n" "$username"
sleep 1
printf "Password : (Change Now!)\n"
sleep 1
passwd
sleep 3
printf "\nStarting LAMP...\n"
sleep 1

sshd &

sleep 3

httpd &

sleep 3

mysqld &

sleep 3
printf "#!/bin/bash

sshd &

httpd &

mysqld &

exit &

exit

">start-slamp.sh
chmod +x start-slamp.sh
sleep 1
printf "Well Done...\n\n"
sleep 3
printf "Connect: ssh-client %s -p 8022\n" "$ipaddress" 
printf "UserName: %s \n" "$username"
printf "Password: ******** \n\n" "$username"
sleep 3
printf "Please visit http://localhost:8080/...\n"
printf "or visit http://%s:8080/...\n\n" "$ipaddress"
sleep 3
