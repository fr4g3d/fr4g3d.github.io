#!/bin/bash
# Requirements
sudo apt-get -y update
sudo apt-get -y install git make gcc g++ zlib1g-dev libpcre3-dev mariadb-server mariadb-client libdbd-mysql-perl libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat
sleep 2
sudo apt-get -y install git make libmariadb-dev libmariadbclient-dev libmariadbclient-dev-compat gcc g++ zlib1g-dev libpcre3-dev
sleep 2
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/rAthena-2018-10-10.zip
sudo mkdir ~/rslRO/rAthena-20181010
sudo unzip -o dlds/rAthena-2018-10-10.zip -d ~/rslRO/rAthena-20181010
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
chmod +x configure
./configure --enable-64bit --enable-packetver=20100831 --enable-prere=yes --with-MYSQL_LIBS=/usr/lib/x86_64-linux-gnu/libmariadbclient.so
make clean && make server
chmod +x *-server
./athena-start restart
sleep 2
echo Well Done..
sleep 1
echo Type: ./athena-start start 
echo to Start Server
sleep 1
./athena-start restart
sleep 1
