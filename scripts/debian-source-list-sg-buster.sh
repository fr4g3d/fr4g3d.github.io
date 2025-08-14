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
#deb  http://mr.heru.id/debian/ buster main contrib non-free
#deb-src http://mr.heru.id/debian/ buster main contrib non-free

#deb  http://ftp.sg.debian.org/debian/ buster main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ buster main contrib non-free

#deb http://ftp.sg.debian.org/debian-security/ buster/updates main contrib non-free
#deb-src http://ftp.sg.debian.org/debian-security/ buster/updates main contrib non-free

#deb http://ftp.sg.debian.org/debian/ buster-backports main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ buster-backports main contrib non-free

# Archive
deb http://archive.debian.org/debian/ buster main contrib non-free
deb-src http://archive.debian.org/debian/ buster main contrib non-free
deb http://archive.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://archive.debian.org/debian-security/ buster/updates main contrib non-free
deb http://archive.debian.org/debian/ buster-backports main contrib non-free
deb-src http://archive.debian.org/debian/ buster-backports main contrib non-free

\" > /etc/apt/sources.list.d/deb-buster.list"
sleep 2
sudo apt-get update
