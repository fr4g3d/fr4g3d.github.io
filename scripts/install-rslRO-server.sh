#!/bin/bash
# Install Ragnarok Private Server
clear
#
# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/install-lamp.sh)
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/enable-fastcgi.sh)
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/install-phpmyadmin.sh)
sleep 2
bash <(wget -O - https://fr4g3d.github.io/scripts/install-rslRO-l2tp.sh)
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/rslRO-web.zip
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/rAthena-2018-10-10.zip
sleep 1
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/www
sleep 1
mkdir ~/rslRO/rAthena-20181010
sleep 1
unzip -o dlds/rslRO-web.zip -d ~/rslRO/www
sudo sh -c "printf \"<?php phpcredits(); ?>
\" > /home/sadmin/rslRO/www/index.php"
sleep 2
unzip -o dlds/rAthena-2018-10-10.zip -d ~/rslRO/rAthena-20181010
sleep 1
sudo chown -R www-data ~/rslRO/www/rslRO/data/
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
echo Install rslRO DB...
sudo mysql -uroot < rslrodb.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/main.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/logs.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_cash_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_cash_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/item_db2_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_db2_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db2.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/mob_skill_db2_re.sql
sudo mysql -uroot -D rslrodb < ~/rslRO/rAthena-20181010/sql-files/roulette_default_data.sql
sleep 1
cd ~/rslRO/rAthena-20181010
sleep 1
echo Configure rAthena Compiler...
sudo chmod +x configure
./configure --enable-64bit --enable-packetver=20100831 --enable-prere=yes --with-MYSQL_LIBS=/usr/lib/x86_64-linux-gnu/libmariadbclient.so
sleep 2

if [[ -f login-server && -f char-server && -f map-server ]]; then
    echo Files Exist! Skip Compiling...
	sleep 2
else
	echo Make rAthena Servers...
	make -C ~/rslRO/rAthena-20181010 clean && make -C ~/rslRO/rAthena-20181010 server
fi
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
