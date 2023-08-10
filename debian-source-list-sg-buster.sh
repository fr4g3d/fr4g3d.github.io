#!/bin/bash
#
# Import APT Source.List
#
clear
#

sudo sh -c "printf \"

#
deb  http://ftp.sg.debian.org/debian/ buster main non-free contrib
deb-src http://ftp.sg.debian.org/debian/ buster main non-free contrib

deb http://ftp.sg.debian.org/debian/ buster-updates main non-free contrib
deb-src http://ftp.sg.debian.org/debian/ buster-updates main non-free contrib

deb http://deb.debian.org/debian/ buster-backports main non-free contrib
deb-src http://deb.debian.org/debian/ buster-backports main non-free contrib

#deb http://ftp.sg.debian.org/debian/ unstable main non-free contrib
#deb-src http://ftp.sg.debian.org/debian/ unstable main non-free contrib

deb http://deb.debian.org/debian-security buster/updates main non-free contrib
deb-src http://deb.debian.org/debian-security buster/updates main non-free contrib

#
#deb http://mirror.coganng.com/debian/ buster main non-free contrib
#deb-src http://mirror.coganng.com/debian/ buster main non-free contrib

#deb http://mirror.coganng.com/debian/ buster-updates main non-free contrib
#deb-src http://mirror.coganng.com/debian/ buster-updates main non-free contrib

#deb http://mirror.coganng.com/debian/ unstable main non-free contrib
#deb-src http://mirror.coganng.com/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security buster/updates main non-free contrib
#deb-src http://deb.debian.org/debian-security buster/updates main non-free contrib

#
deb http://mirror.sg.gs/debian/ buster main non-free contrib
deb-src http://mirror.sg.gs/debian/ buster main non-free contrib

deb http://mirror.sg.gs/debian/ buster-updates main non-free contrib
deb-src http://mirror.sg.gs/debian/ buster-updates main non-free contrib

#deb http://mirror.sg.gs/debian/ unstable main non-free contrib
#deb-src http://mirror.sg.gs/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security buster/updates main non-free contrib
#deb-src http://deb.debian.org/debian-security buster/updates main non-free contrib

#
#deb http://mirror.soonkeat.sg/debian/ buster main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ buster main non-free contrib

#deb http://mirror.soonkeat.sg/debian/ buster-updates main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ buster-updates main non-free contrib

#deb http://mirror.soonkeat.sg/debian/ unstable main non-free contrib
#deb-src http://mirror.soonkeat.sg/debian/ unstable main non-free contrib

#deb http://deb.debian.org/debian-security buster/updates main non-free contrib
#deb-src http://deb.debian.org/debian-security buster/updates main non-free contrib
\" >> /etc/apt/sources.list"
sleep 2
sudo apt update
