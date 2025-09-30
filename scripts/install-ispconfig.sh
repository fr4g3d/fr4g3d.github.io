#!/bin/bash
#
clear
sudo apt-get update
sleep 3
# Get the Debian version ID
DEBIAN_VERSION=$(grep -oP 'VERSION_ID="\K[^"]+' /etc/os-release)

# Check if the version is less than or equal to 10
if (( $(echo "$DEBIAN_VERSION <= 10" | bc -l) )); then
    echo "Debian version is $DEBIAN_VERSION, which is less than or equal to 10."
    # Add your commands here for Debian versions <= 10
	exit
else
    echo "Debian version is $DEBIAN_VERSION, which is greater than 10."
	echo "Preparing Install ISPConfig"
    # Add your commands here for Debian versions > 10
fi
sleep 2
# Check if php command exists
#php -v
if ! command php -v &> /dev/null; then
    echo "PHP is not installed. Installing PHP..."
	sleep 2
	sudo apt-get -y install php php-fpm php-common libapache2-mod-php php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-apcu php-redis php-imagick
	sudo apt-get -y install redis-server php-redis php-apcu php-memcached memcached
	sudo php -v
    echo "PHP installation complete."
	sleep 2
else
    echo "PHP is already installed."
    php -v
	sudo apt-get -y install php php-fpm php-common libapache2-mod-php php-xml php-curl php-gd php-json php-mbstring php-zip php-sqlite3 php-mysql php-pgsql php-bz2 php-intl php-ldap php-imap php-bcmath php-gmp php-apcu php-redis php-imagick
	sudo apt-get -y install redis-server php-redis php-apcu php-memcached memcached
	sleep 2
fi
sleep 2
cd /tmp
wget -nc https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar -xvzf ioncube_loaders_lin_x86-64.tar.gz
cd ioncube
ls
php -i | grep /.+/php.ini -oE
php -r 'echo ini_get("extension_dir");'
php -v | head -n 1 | grep -oP 'PHP \K[0-9]+\.[0-9]+'
NOW=$(date)
PHPINI="$(php -i | grep /.+/php.ini -oE)"
PHPEXTDIR="$(php -r 'echo ini_get("extension_dir");')"
PHPMAJVER="$(php -v | head -n 1 | grep -oP 'PHP \K[0-9]+\.[0-9]+')"

printf "$NOW\n"
printf "${PHPINI}\n"
printf "${PHPEXTDIR}\n"
printf "The PHP Version is: ${PHPMAJVER}\n"

sudo cp ioncube_loader_lin_${PHPMAJVER}.so ${PHPEXTDIR}/
# zend_extension = ${PHPEXTDIR}/ioncube_loader_lin_${PHPMAJVER}.so
sudo sh -c -E "printf \"
zend_extension = $PHPEXTDIR/ioncube_loader_lin_$PHPMAJVER.so
\" > $PHPINI "
sudo systemctl restart apache2
sudo a2dismod php${PHPMAJVER}
sudo a2dismod mpm_prefork
sudo a2enmod mpm_event proxy proxy_fcgi
sudo a2enconf php${PHPMAJVER}-fpm
sudo systemctl enable php${PHPMAJVER}-fpm
sudo systemctl restart php${PHPMAJVER}-fpm
php -m | grep ionCube
sleep 3
cd
sleep 2
sudo apt-get update
sudo apt install -y apt-transport-https lsb-release ca-certificates curl gnupg gnupg2
curl -fsSL https://packages.sury.org/php/apt.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-php.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
curl -sSL https://rspamd.com/apt-stable/gpg.key | sudo apt-key add -
echo "deb [arch=amd64] https://rspamd.com/apt-stable/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/rspamd.list
wget -O - https://deb.goaccess.io/gnugpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/goaccess.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/goaccess.gpg arch=$(dpkg --print-architecture)] https://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/goaccess.list
sudo apt-get update
sleep 2
sudo apt-get install -y ssh openssh-server nano vim-nox lsb-release apt-transport-https ca-certificates wget git gnupg software-properties-common curl cron ntp
sudo apt-get install -y dbconfig-common mariadb-client mariadb-server openssl rkhunter binutils sudo getmail dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-managesieved dovecot-lmtpd
sudo apt-get install -y software-properties-common update-inetd dnsutils clamav clamav-daemon zip unzip bzip2 xz-utils lzip borgbackup arj nomarch lzop cabextract apt-listchanges libnet-ldap-perl libauthen-sasl-perl
sudo apt-get install -y daemon libio-string-perl libio-socket-ssl-perl libnet-ident-perl libnet-dns-perl libdbd-mysql-perl bind9 rspamd redis-server p7zip p7zip-full unrar-free lrzip
echo "Installing PHP Old to Current..."
sleep 2
sudo apt-get install -y php5.6 php5.6-common php5.6-gd php5.6-mysql php5.6-imap php5.6-cli php5.6-mcrypt php5.6-curl php5.6-intl php5.6-pspell php5.6-recode php5.6-sqlite3 php5.6-tidy php5.6-xmlrpc php5.6-xsl php5.6-zip php5.6-mbstring php5.6-soap php5.6-opcache php5.6-cgi php5.6-fpm
sudo apt-get install -y php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-imap php7.0-cli php7.0-mcrypt php7.0-curl php7.0-intl php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-zip php7.0-mbstring php7.0-soap php7.0-opcache php7.0-cgi php7.0-fpm
sudo apt-get install -y php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-imap php7.1-cli php7.1-mcrypt php7.1-curl php7.1-intl php7.1-pspell php7.1-recode php7.1-sqlite3 php7.1-tidy php7.1-xmlrpc php7.1-xsl php7.1-zip php7.1-mbstring php7.1-soap php7.1-opcache php7.1-cgi php7.1-fpm
sudo apt-get install -y php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-imap php7.2-cli php7.2-curl php7.2-intl php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-zip php7.2-mbstring php7.2-soap php7.2-opcache php7.2-cgi php7.2-fpm
sudo apt-get install -y php7.3 php7.3-common php7.3-gd php7.3-mysql php7.3-imap php7.3-cli php7.3-curl php7.3-intl php7.3-pspell php7.3-recode php7.3-sqlite3 php7.3-tidy php7.3-xmlrpc php7.3-xsl php7.3-zip php7.3-mbstring php7.3-soap php7.3-opcache php7.3-cgi php7.3-fpm
sudo apt-get install -y php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-imap php7.4-cli php7.4-curl php7.4-intl php7.4-pspell php7.4-recode php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl php7.4-zip php7.4-mbstring php7.4-soap php7.4-opcache php7.4-cgi php7.4-fpm
sudo apt-get install -y php8.0 php8.0-common php8.0-gd php8.0-mysql php8.0-imap php8.0-cli php8.0-curl php8.0-intl php8.0-pspell php8.0-sqlite3 php8.0-tidy php8.0-xsl php8.0-zip php8.0-mbstring php8.0-soap php8.0-opcache php8.0-cgi php8.0-fpm
sudo apt-get install -y php8.1 php8.1-common php8.1-gd php8.1-mysql php8.1-imap php8.1-cli php8.1-curl php8.1-intl php8.1-pspell php8.1-sqlite3 php8.1-tidy php8.1-xsl php8.1-zip php8.1-mbstring php8.1-soap php8.1-opcache php8.1-cgi php8.1-fpm
sudo apt-get install -y php8.2 php8.2-common php8.2-gd php8.2-mysql php8.2-imap php8.2-cli php8.2-curl php8.2-intl php8.2-pspell php8.2-sqlite3 php8.2-tidy php8.2-xsl php8.2-zip php8.2-mbstring php8.2-soap php8.2-opcache php8.2-cgi php8.2-fpm
sudo apt-get install -y php8.3 php8.3-common php8.3-gd php8.3-mysql php8.3-imap php8.3-cli php8.3-curl php8.3-intl php8.3-pspell php8.3-sqlite3 php8.3-tidy php8.3-xsl php8.3-zip php8.3-mbstring php8.3-soap php8.3-opcache php8.3-cgi php8.3-fpm
sudo apt-get install -y php8.4 php8.4-common php8.4-gd php8.4-mysql php8.4-imap php8.4-cli php8.4-curl php8.4-intl php8.4-pspell php8.4-sqlite3 php8.4-tidy php8.4-xsl php8.4-zip php8.4-mbstring php8.4-soap php8.4-opcache php8.4-cgi php8.4-fpm
sleep 2
sudo apt-get install haveged, geoip-database, libclass-dbi-mysql-perl, libtimedate-perl, build-essential, autoconf, automake, libtool, flex, bison, debhelper, binutils
sleep 2
sudo apt-get install fail2ban, ufw
sleep 2
sudo apt-get install roundcube, roundcube-core, roundcube-mysql, roundcube-plugins
sleep 2
echo "Done Preparing..."
sleep 2
echo "Start ISPConfig Installer..."
sleep 2
#wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --debug
wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --unattended-upgrades --debug
#wget -O - https://get.ispconfig.org | sudo bash -s -- --use-nginx --use-ftp-ports=40110-40210 --unattended-upgrades --debug
sleep 2
sudo apt-get install -y apache2-doc
sleep 2
sudo a2enconf apache2-doc
sleep 2
sudo systemctl reload apache2
sleep 2
read -n 1 -s -r -p "Press Enter to continue Install Softaculous.."
echo 
sleep 5
read -n 1 -s -r -p "Press Enter to continue Install Softaculous.."
echo 
sleep 3
#
wget -N https://files.softaculous.com/install.sh
sudo bash ./install.sh
#
exit
