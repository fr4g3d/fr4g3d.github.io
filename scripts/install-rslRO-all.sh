#!/bin/bash
#
clear
#
# Install rslRO Complete.
sleep 1
echo "Install [rslRO-L2TP-Server] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-rslRO-l2tp.sh)
sleep 1
echo "Install [rslRO-Web-Server] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-rslRO-web.sh)
sleep 1
echo "Install [rslRO-Game-Server] Start..."
sleep 2
bash <(wget -O - http://fr4g3d.github.io/scripts/install-rslRO-server.sh)
sleep 2
echo All Well Done..
sleep 1
