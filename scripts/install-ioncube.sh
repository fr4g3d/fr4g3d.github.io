#!/bin/bash
#
sudo apt udpate
# install php php-commons.
sudo apt-get -y install php php-fpm php-common php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-apcu php-redis php-imagick
sudo apt-get -y install redis-server php-redis php-apcu php-memcached memcached
sudo php -v
sleep 2
cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar -xvzf ioncube_loaders_lin_x86-64.tar.gz
cd ioncube
ls
php -i | grep /.+/php.ini -oE
php -r 'echo ini_get("extension_dir");'
echo
php -v | head -n 1 | grep -oP 'PHP \K[0-9]+\.[0-9]+'
NOW=$(date)
PHPINI="$(php -i | grep /.+/php.ini -oE)"
PHPEXTDIR="$(php -r 'echo ini_get("extension_dir");')"
PHPMAJVER="$(php -v | head -n 1 | grep -oP 'PHP \K[0-9]+\.[0-9]+')"

printf "$NOW\n"
printf "$PHPINI\n"
printf "${PHPEXTDIR}\n"
printf "The PHP Version is: ${PHPMAJVER}\n"

sudo cp ioncube_loader_lin_7.3.so /usr/lib/php/20180731/
zend_extension = /usr/lib/php/20180731/ioncube_loader_lin_7.3.so
sudo sh -c "
zend_extension = /usr/lib/php/20180731/ioncube_loader_lin_7.3.so
\" > /etc/php/7.3/cli/php.ini"
sudo systemctl restart apache2
sudo systemctl restart php7.3-fpm
php -m | grep ionCube
cd
wget -N https://files.softaculous.com/install.sh
sudo bash ./install.sh
