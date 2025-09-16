#!/bin/bash
#
# Import -APT- Source.List
#
clear
#

# Always SysAdmin Message
sudo sh -c "printf \"Defaults        lecture = always\n\" >> /etc/sudoers.d/privacy"
sleep 2

sudo sh -c "printf \"

#
#deb  http://mr.heru.id/debian/ bullseye main contrib non-free
#deb-src http://mr.heru.id/debian/ bullseye main contrib non-free

#deb  http://ftp.sg.debian.org/debian/ bullseye main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ bullseye main contrib non-free

#deb http://ftp.sg.debian.org/debian-security/ bullseye/updates main contrib non-free
#deb-src http://ftp.sg.debian.org/debian-security/ bullseye/updates main contrib non-free

#deb http://ftp.sg.debian.org/debian/ bullseye-backports main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ bullseye-backports main contrib non-free

# Archive
deb http://archive.debian.org/debian/ bullseye main contrib non-free
deb-src http://archive.debian.org/debian/ bullseye main contrib non-free
deb http://security.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://security.debian.org/debian-security/ bullseye-security main contrib non-free
deb http://archive.debian.org/debian/ bullseye-backports main contrib non-free
deb-src http://archive.debian.org/debian/ bullseye-backports main contrib non-free

\" > /etc/apt/sources.list.d/deb-bullseye.list"
sleep 2
sudo apt-get update
