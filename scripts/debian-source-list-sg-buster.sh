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
deb  http://ftp.sg.debian.org/debian/ buster main contrib non-free
deb-src http://ftp.sg.debian.org/debian/ buster main contrib non-free

deb http://ftp.sg.debian.org/debian/ buster-updates main contrib non-free
deb-src http://ftp.sg.debian.org/debian/ buster-updates main contrib non-free

#deb http://ftp.sg.debian.org/debian/ unstable main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ unstable main contrib non-free

deb http://deb.debian.org/debian-security buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security buster/updates main contrib non-free

#
#deb http://mirror.coganng.com/debian/ buster main contrib non-free
#deb-src http://mirror.coganng.com/debian/ buster main contrib non-free

#deb http://mirror.coganng.com/debian/ buster-updates main contrib non-free
#deb-src http://mirror.coganng.com/debian/ buster-updates main contrib non-free

#deb http://mirror.coganng.com/debian/ unstable main contrib non-free
#deb-src http://mirror.coganng.com/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security buster/updates main contrib non-free

#
deb http://mirror.sg.gs/debian/ buster main contrib non-free
deb-src http://mirror.sg.gs/debian/ buster main contrib non-free

deb http://mirror.sg.gs/debian/ buster-updates main contrib non-free
deb-src http://mirror.sg.gs/debian/ buster-updates main contrib non-free

#deb http://mirror.sg.gs/debian/ unstable main contrib non-free
#deb-src http://mirror.sg.gs/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security buster/updates main contrib non-free

#
#deb http://mirror.soonkeat.sg/debian/ buster main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ buster main contrib non-free

#deb http://mirror.soonkeat.sg/debian/ buster-updates main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ buster-updates main contrib non-free

#deb http://mirror.soonkeat.sg/debian/ unstable main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security buster/updates main contrib non-free

# Archive
#deb http://archive.debian.org/debian/ buster main contrib non-free
#deb http://archive.debian.org/debian-security/ buster/updates main contrib non-free
\" > /etc/apt/sources.list.d/deb-adds.list"
sleep 2
sudo apt-get update
