#!/bin/bash
#
clear
#
# Install [idRO-MediaWiki]
sudo apt-get update
sleep 2
printf "Download idRO-MediaWiki Package...\n"
sleep 3
#aria2c -d dlds/ -c -s8 -j8 -x8 https://releases.wikimedia.org/mediawiki/1.28/mediawiki-1.28.3.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/mediawiki-1.28.3.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/CollapsibleVector-refs_heads_REL1_28.tar.gz
sleep 2
mkdir ~/rslRO
sleep 1
mkdir ~/rslRO/www
sleep 1
tar -xzvf dlds/mediawiki-1.28.3.tar.gz -C ~/rslRO/www
sleep 1
mv ~/rslRO/www/mediawiki-1.28.3 ~/rslRO/www/idRO-Wiki
sleep 2
tar -xzvf dlds/CollapsibleVector-refs_heads_REL1_28.tar.gz -C ~/rslRO/www/idRO-Wiki/extensions/CollapsibleVector
sleep 2
echo Well Done.
sleep 1
: '
$wgArticlePath = "/idRO-Wiki/$1";
$wgLogos = [ '1x' => "https://idrowiki.org/c/images/idrowiki-logo.png?206dd" ];
$wgRawHtml = true;
$wgAllowExternalImages = true;
$wgAllowExternalImagesFrom = [
    "http://ro.rsl.my.id:88/",
    "https://idrowiki.org/"
];
'
