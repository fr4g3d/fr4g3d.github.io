#!/bin/bash
#
clear
sudo apt-get update
sleep 3
VERSION=$(sed 's/\..*//' /etc/debian_version)
if [[ $VERSION <= '10' ]]; then
  echo "Cannot install on Debian <= 10 , only for Debian >= 11"
  exit
elif [[ $VERSION >= '11' ]]; then
  echo "Preparing Install ISPConfig"
fi
sleep 2
sudo apt-get update
sudo apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
sudo apt-get update
sleep 2
sudo apt-get install -y ssh openssh-server nano vim-nox lsb-release apt-transport-https ca-certificates wget git gnupg software-properties-common curl cron ntp
sudo apt-get install -y dbconfig-common postfix postfix-mysql mariadb-client mariadb-server openssl rkhunter binutils sudo getmail dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-managesieved dovecot-lmtpd
sudo apt-get install -y software-properties-common update-inetd dnsutils resolvconf clamav clamav-daemon zip unzip bzip2 xz-utils lzip borgbackup arj nomarch lzop cabextract apt-listchanges libnet-ldap-perl libauthen-sasl-perl daemon libio-string-perl libio-socket-ssl-perl libnet-ident-perl libnet-dns-perl libdbd-mysql-perl bind9 rspamd redis-server postgrey p7zip p7zip-full unrar-free lrzip
echo "Installing PHP Old to Current..."
sleep 2
sudo apt-get install -y php5.6 php5.6-common php5.6-gd php5.6-mysql php5.6-imap php5.6-cli php5.6-mcrypt php5.6-curl php5.6-intl php5.6-pspell php5.6-recode php5.6-sqlite3 php5.6-tidy php5.6-xmlrpc php5.6-xsl php5.6-zip php5.6-mbstring php5.6-soap php5.6-opcache php5.6-cgi php5.6-fpm
sudo apt-get install -y php7.0 php7.0-common php7.0-gd php7.0-mysql php7.0-imap php7.0-cli php7.0-mcrypt php7.0-curl php7.0-intl php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-zip php7.0-mbstring php7.0-soap php7.0-opcache php7.0-cgi php7.0-fpm
sudo apt-get install -y php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-imap php7.1-cli php7.1-mcrypt php7.1-curl php7.1-intl php7.1-pspell php7.1-recode php7.1-sqlite3 php7.1-tidy php7.1-xmlrpc php7.1-xsl php7.1-zip php7.1-mbstring php7.1-soap php7.1-opcache php7.1-cgi php7.1-fpm
sudo apt-get install -y php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-imap php7.2-cli php7.2-curl php7.2-intl php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-zip php7.2-mbstring php7.2-soap php7.2-opcache php7.2-cgi php7.2-fpm
sudo apt-get install -y php7.3 php7.3-common php7.3-gd php7.3-mysql php7.3-imap php7.3-cli php7.3-curl php7.3-intl php7.3-pspell php7.3-recode php7.3-sqlite3 php7.3-tidy php7.3-xmlrpc php7.3-xsl php7.3-zip php7.3-mbstring php7.3-soap php7.3-opcache php7.3-cgi php7.3-fpm
sudo apt-get install -y php php-common php-gd php-mysql php-imap php-cli php-curl php-intl php-pspell php-sqlite3 php-tidy php-xmlrpc php-xsl php-zip php-mbstring php-soap php-opcache php-cgi php-fpm
sleep 1
echo "Done Preparing..."
sleep 2
echo "Start ISPConfig Installer..."
sleep 2
wget -O - https://get.ispconfig.org | sudo bash -s -- --use-ftp-ports=40110-40210 --unattended-upgrades --debug
sleep 2
#
#wget -N https://files.softaculous.com/install.sh
#sudo bash ./install.sh
#
exit
