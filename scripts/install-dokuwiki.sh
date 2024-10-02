#!/bin/bash
#
clear
#
# Install [DokuWiki]
sudo apt-get update
sleep 2
printf "Download DokuWiki Package...\n"
sleep 3
rm dokuwiki-2023-04-04a.tgz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/dokuwiki-2023-04-04a.tgz
sleep 2
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/idRO-Wiki
sleep 1
tar -xzvf dlds/dokuwiki-2023-04-04a.tgz -C ~/rslRO/idRO-Wiki
sleep 2
echo Done.
sleep 1
