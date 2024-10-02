#!/bin/bash
#
clear
#
# Install [idRO-DokuWiki]
sudo apt-get update
sleep 2
printf "Download idRO-DokuWiki Package...\n"
sleep 3
rm dokuwiki-2023-04-04a.tgz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/dokuwiki-2023-04-04a.tgz
sleep 2
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/www
sleep 1
mkdir ~/rslRO/www/idRO-Wiki
sleep 1
tar -xzvf dlds/dokuwiki-2023-04-04a.tgz -C ~/rslRO/www/idRO-Wiki
sleep 2
echo Well Done.
sleep 1
