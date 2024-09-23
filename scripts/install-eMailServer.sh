#!/bin/bash
#
# Installer eMail Server.
#
clear
#

sudo apt update
sleep 2
# install common apps and Downloader.
sudo apt-get -y install curl wget aria2 coreutils
sleep 2
echo "Install [LAMP] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-lamp.sh)
echo "Install [FastCGi] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/enable-fastcgi.sh)
echo "Install [phpMyAdmin] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-phpmyadmin.sh)
sleep 2
clear
sudo sh -c "printf \"GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'localhost' IDENTIFIED BY 'roundcube@123' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON roundcube.* TO 'roundcube'@'localhost' IDENTIFIED BY 'roundcube@123' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\" > roundcube.sql"
printf "type \"source roundcube.sql\"\n"
sleep 2
sudo apt-get -y install roundcube
sleep 2
sudo mysql -uroot < roundcube.sql
sleep 2
# install eMail Server Apps.
sudo apt-get -y install postfix dovecot-pop3d dovecot-imapd bind9
sleep 2
sudo maildirmake.dovecot /etc/skel/Maildir
sudo sh -c "printf \"
home_mailbox = Maildir/
\" >> /etc/postfix/main.cf"
sleep 1
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/dovecot-conf.zip
sleep 1
unzip -o dlds/dovecot-conf.zip
sleep 1
sudo mv -f dovecot.conf /etc/dovecot/dovecot.conf
sudo mv -f 10-mail.conf /etc/dovecot/conf.d/10-mail.conf
sudo mv -f 10-auth.conf /etc/dovecot/conf.d/10-auth.conf
sleep 2
sudo dpkg-reconfigure postfix
sleep 2
sudo systemctl restart postfix
sudo systemctl restart dovecot
sudo systemctl restart bind9
sleep 2
sudo sh -c "printf \"Alias /mailz /var/lib/roundcube/
<Directory /mailz /var/lib/roundcube/>
  Require all granted
  AllowOverride All
  Options Indexes Includes FollowSymLinks MultiViews
</Directory>
\" > /etc/apache2/sites-available/mailz.conf"
sudo a2ensite mailz
sleep 1
sudo systemctl restart apache2
sleep 2
echo Install [eMail-Server] is Done.
sleep 3
