#!/bin/bash
# Install Ragnarok Private Server
clear
#
# install apache2 mod-php openssl.
sudo apt-get update
sudo apt-get -y install curl wget zip unzip aria2
sleep 2
echo "Install [rslRO-Game-Server] Start..."
sleep 2
sudo apt-get -y install git make gcc g++ zlib1g-dev libpcre3-dev mariadb-server mariadb-client libdbd-mysql-perl libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 http://fr4g3d.github.io/sarch/rAthena-2018-10-10.zip
sleep 1
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/rAthena-20181010
sleep 1
unzip -o dlds/rAthena-2018-10-10.zip -d ~/rslRO/rAthena-20181010
sleep 2
sudo sh -c "printf \"CREATE DATABASE rslrodb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON rslrodb.* TO 'rslrouser'@'localhost' IDENTIFIED BY 'rslro@123';
FLUSH PRIVILEGES;
\"  > rslrodb.sql"
sleep 2
sudo mysql -uroot < rslrodb.sql
sleep 2
echo Install rslRO DB...
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
