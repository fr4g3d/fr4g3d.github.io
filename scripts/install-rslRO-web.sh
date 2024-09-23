#!/bin/bash
# Install Ragnarok Private Server
clear
#
# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
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
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/rslRO-web.zip
sleep 2
sleep 1
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/www
sleep 1
unzip -o dlds/rslRO-web.zip -d ~/rslRO/www
sleep 1
sudo chown -R www-data ~/rslRO/www/rslRO/data/logs
sudo chown -R www-data ~/rslRO/www/rslRO/data/itemshop
sudo chown -R www-data ~/rslRO/www/rslRO/data/tmp
sleep 1
sudo sh -c "printf \"<?php phpcredits(); ?>
\" > /home/sadmin/rslRO/www/index.php"
sleep 2
sudo bash -c 'cat > /etc/apache2/sites-available/rslRO.lan.conf <<EOF
<VirtualHost *:80>
     ServerAdmin admin@rsl.my.id
     DocumentRoot /home/sadmin/rslRO/www/
     ServerName ro.rsl.my.id
     ServerAlias www.ro.rsl.my.id rslro.lan

    <FilesMatch \.php$>
        # 2.4.10+ can proxy to unix socket
        SetHandler "proxy:unix:/run/php/php7.3-fpm.sock|fcgi://localhost"
    </FilesMatch>

     <Directory /home/sadmin/rslRO/www/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
          <IfModule mod_dav.c>
            Dav off
          </IfModule>
        SetEnv HOME /home/sadmin/rslRO/www
        SetEnv HTTP_HOME /home/sadmin/rslRO/www
     </Directory>

     ErrorLog /var/log/apache2/rslRO.lan-error.log
     CustomLog /var/log/apache2/rslRO.lan-access.log combined

</VirtualHost>

<IfModule mod_ssl.c>
<VirtualHost _default_:443>
     ServerAdmin admin@rsl.my.id
     DocumentRoot /home/sadmin/rslRO/www/
     ServerName ro.rsl.my.id
     ServerAlias www.ro.rsl.my.id rslro.lan

    <FilesMatch \.php$>
        # 2.4.10+ can proxy to unix socket
        SetHandler "proxy:unix:/run/php/php7.3-fpm.sock|fcgi://localhost"
    </FilesMatch>

     <Directory /home/sadmin/rslRO/www/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
          <IfModule mod_dav.c>
            Dav off
          </IfModule>
        SetEnv HOME /home/sadmin/rslRO/www
        SetEnv HTTP_HOME /home/sadmin/rslRO/www
     </Directory>

    ErrorLog /var/log/apache2/rslRO.lan-ssl-error.log
    CustomLog /var/log/apache2/rslRO.lan-ssl-access.log combined

SSLEngine on
SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

<FilesMatch "\.(cgi|shtml|phtml|php)$">
SSLOptions +StdEnvVars
</FilesMatch>
<Directory /usr/lib/cgi-bin>
SSLOptions +StdEnvVars
</Directory>

</VirtualHost>
</IfModule>
EOF'
sudo a2ensite rslRO.lan
sleep 1
sudo service apache2 restart
sleep 2
echo Well Done..
sleep 1

