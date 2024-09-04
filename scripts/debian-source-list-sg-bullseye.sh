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
deb  http://mr.heru.id/debian/ buster main contrib non-free
deb-src http://mr.heru.id/debian/ buster main contrib non-free

deb  http://ftp.sg.debian.org/debian/ bullseye main contrib non-free
deb-src http://ftp.sg.debian.org/debian/ bullseye main contrib non-free

deb http://ftp.sg.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://ftp.sg.debian.org/debian/ bullseye-updates main contrib non-free

#deb http://ftp.sg.debian.org/debian/ unstable main contrib non-free
#deb-src http://ftp.sg.debian.org/debian/ unstable main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

#
#deb http://mirror.coganng.com/debian/ bullseye main contrib non-free
#deb-src http://mirror.coganng.com/debian/ bullseye main contrib non-free

#deb http://mirror.coganng.com/debian/ bullseye-updates main contrib non-free
#deb-src http://mirror.coganng.com/debian/ bullseye-updates main contrib non-free

#deb http://mirror.coganng.com/debian/ unstable main contrib non-free
#deb-src http://mirror.coganng.com/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
#deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

#
#deb http://mirror.sg.gs/debian/ bullseye main contrib non-free
#deb-src http://mirror.sg.gs/debian/ bullseye main contrib non-free

#deb http://mirror.sg.gs/debian/ bullseye-updates main contrib non-free
#deb-src http://mirror.sg.gs/debian/ bullseye-updates main contrib non-free

#deb http://mirror.sg.gs/debian/ unstable main contrib non-free
#deb-src http://mirror.sg.gs/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
#deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

#
#deb http://mirror.soonkeat.sg/debian/ bullseye main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ bullseye main contrib non-free

#deb http://mirror.soonkeat.sg/debian/ bullseye-updates main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ bullseye-updates main contrib non-free

#deb http://mirror.soonkeat.sg/debian/ unstable main contrib non-free
#deb-src http://mirror.soonkeat.sg/debian/ unstable main contrib non-free

#deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
#deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

# Archive
#deb http://archive.debian.org/debian/ bullseye main contrib non-free
#deb http://archive.debian.org/debian-security/ bullseye/updates main contrib non-free
\" > /etc/apt/sources.list.d/deb-adds.list"
sleep 2
sudo apt-get update
