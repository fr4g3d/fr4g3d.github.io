#!/bin/bash
#
# Nextcloud v.21.0.4 Installer for ncmbd-debx Server.
#
clear
#

# install apache2 mod-php openssl.
sudo apt update
sleep 2
sudo apt -y install fdisk mhddfs
sleep 2
sudo fdisk /dev/sdb
sleep 2
sudo mkfs.ext4 /dev/sdb1
sleep 2
sudo mkdir -p /mnt/ncd0
sudo mount -o defaults /dev/sdb1 /mnt/ncd0
sleep 2
sudo printf "/dev/sdb1 /mnt/ncd0 ext4 defaults 0 2\n" | sudo tee -a /etc/fstab
sudo mkdir -p /mnt/fncd
sudo chown www-data /mnt/fncd
sudo mhddfs /var/www/html/.apps/nextcloud/data,/mnt/ncd0 /mnt/fncd -o allow_other,nonempty
sleep 2
sudo -u www-data php /var/www/html/.apps/nextcloud/occ maintenance:mode --on
sudo nano /var/www/html/.apps/nextcloud/config/config.php
sleep 2
sudo -u www-data php /var/www/html/.apps/nextcloud/occ maintenance:mode --off
sudo printf "mhddfs#/var/www/html/.apps/nextcloud/data,/mnt/ncd0 /mnt/fncd fuse defaults,allow_other,nonempty 0 0\n" | sudo tee -a /etc/fstab
sleep 2
clear
