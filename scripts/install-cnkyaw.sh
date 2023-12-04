#!/bin/bash
#
# TouchPad Toggle Script.
#
clear
#
sudo apt-get -y install curl wget aria2 zip unzip tar gzip
clear
# install TouchPad Toggle Script.
printf "install TouchPad Toggle Script\n"
rm dlds/conky_accu_weather.tar.gz
sleep 3s
#wget https://fr4g3d.github.io/sarch/conky_accu_weather.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/conky_accu_weather.tar.gz
sleep 2s
tar -xf dlds/conky_accu_weather.tar.gz -C dlds/
sleep 2s
# mkdir -p ~/.conky/
cp dlds/accu_weather/ ~/.conky/
sleep 2s
printf "\nPlease Assign this script in the Keyboard Shortcuts to 'sh \"~/.config/tpads/tpt.sh\"'\n"
sleep 2s
printf "and Assign this script in the StartUp Task to 'sh \"~/.config/tpads/tpt.sh\" startup'\n"
sleep 5s
printf "Well Done.."
sleep 3s
clear
exit 0
