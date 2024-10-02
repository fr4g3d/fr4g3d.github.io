#!/bin/bash
#
clear
#
# Install [idRO-MediaWiki]
sudo apt-get update
sleep 2
printf "Download idRO-MediaWiki Package...\n"
sleep 3
#aria2c -d dlds/ -c -s8 -j8 -x8 https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.13.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/mediawiki-1.35.13.tar.gz
sleep 2
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/www
sleep 1
mkdir ~/rslRO/www/idRO-Wiki
sleep 1
tar -xzvf dlds/mediawiki-1.35.13.tar.gz -C ~/rslRO/www
sleep 1
mv ~/rslRO/www/mediawiki-1.35.13 ~/rslRO/www/idRO-Wiki
sleep 2
echo Well Done.
sleep 1
