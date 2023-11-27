#!/bin/bash
#
# TouchPad Toggle Script.
#
clear
#

# install TouchPad Toggle Script.
printf "install TouchPad Toggle Script\n"
rm dlds/touchpad-script.tar.gz
sleep 3s
#wget https://fr4g3d.github.io/sarch/touchpad-script.tar.gz
aria2c -d dlds/ -c -s8 -j8 -x8 https://fr4g3d.github.io/sarch/touchpad-script.tar.gz
sleep 2s
tar -xf dlds/touchpad-script.tar.gz -C dlds/
sleep 2s
mkdir -p ~/.config/tpads/
cp dlds/tpt.sh ~/.config/tpads/
sleep 2s
printf "\nPlease Assign this script in the Keyboard Shortcuts to 'sh \"~/.config/tpads/tpt.sh\"'\n"
sleep 2s
printf "and Assign this script in the StartUp Task to 'sh \"~/.config/tpads/tpt.sh\" startup'\n"
sleep 5s
printf "Well Done.."
sleep 3s
clear
exit 0
