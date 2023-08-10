#!/bin/bash
#
# Import APT Source.List
#
clear
#

sudo echo "

#
deb  http://ftp.sg.debian.org/debian/ bullseye main non-free contrib
deb-src http://ftp.sg.debian.org/debian/ bullseye main non-free contrib

deb http://ftp.sg.debian.org/debian/ bullseye-updates main non-free contrib
deb-src http://ftp.sg.debian.org/debian/ bullseye-updates main non-free contrib

deb http://deb.debian.org/debian/ bullseye-backports main non-free contrib
deb-src http://deb.debian.org/debian/ bullseye-backports main non-free contrib

#deb http://ftp.sg.debian.org/debian/ unstable main non-free contrib
#deb-src http://ftp.sg.debian.org/debian/ unstable main non-free contrib

deb http://deb.debian.org/debian-security/ bullseye-security main non-free contrib
deb-src http://deb.debian.org/debian-security/ bullseye-security main non-free contrib

#
#deb http://mirror.coganng.com/debian/ bullseye main non-free contrib
#deb-src http://mirror.coganng.com/debian/ bullseye main non-free contrib

#deb http://mirror.coganng.com/debian/ bullseye-updates main non-free contrib
#deb-src http://mirror.coganng.com/debian/ bullseye-updates main non-free contrib

#deb http://mirror.coganng.com/debian/ unstable main non-free contrib
#deb-src http://mirror.coganng.com/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security/ bullseye-security main non-free contrib
#deb-src http://deb.debian.org/debian-security/ bullseye-security main non-free contrib

#
deb http://mirror.sg.gs/debian/ bullseye main non-free contrib
deb-src http://mirror.sg.gs/debian/ bullseye main non-free contrib

deb http://mirror.sg.gs/debian/ bullseye-updates main non-free contrib
deb-src http://mirror.sg.gs/debian/ bullseye-updates main non-free contrib

#deb http://mirror.sg.gs/debian/ unstable main non-free contrib
#deb-src http://mirror.sg.gs/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security/ bullseye-security main non-free contrib
#deb-src http://deb.debian.org/debian-security/ bullseye-security main non-free contrib

#
#deb http://mirror.soonkeat.sg/debian/ bullseye main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ bullseye main non-free contrib

#deb http://mirror.soonkeat.sg/debian/ bullseye-updates main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ bullseye-updates main non-free contrib

#deb http://mirror.soonkeat.sg/debian/ unstable main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security/ bullseye-security main non-free contrib
#deb-src http://deb.debian.org/debian-security/ bullseye-security main non-free contrib
" >> /etc/apt/source.list
sleep 2
sudo apt update
