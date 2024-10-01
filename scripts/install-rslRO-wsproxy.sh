#!/bin/bash
#
clear
#
echo Install [rslRO-wsProxy]
sleep 2
sudo apt update
sleep 2
sudo apt -y install npm
sleep 2
sudo npm install wsproxy -g
sleep 2
sudo bash -c 'cat > rslRO-wsproxy.service <<EOF
[Unit]
Description=rslRO wsProxy Service
After=network-online.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=3
User=root
Group=root
ExecStart=/usr/local/bin/rslRO-wsproxy.sh

[Install]
WantedBy=multi-user.target
EOF'
sleep 1
sudo bash -c 'cat > /usr/local/bin/rslRO-wsproxy.sh <<EOF
#!/bin/bash
sleep 2
wsproxy -a 127.0.0.1:6900,127.0.0.1:6121,127.0.0.1:5121
sleep 2
ping -Q 1 -c 3 -t 1 10.66.66.1
sleep 1
echo Done.
EOF'
sleep 1
sudo chmod +x /usr/local/bin/rslRO-wsproxy.sh
sleep 1
sudo mv -f rslRO-wsproxy.service /etc/systemd/system/rslRO-wsproxy.service
sleep 1
sudo systemctl enable rslRO-wsproxy.service
sleep 1
sudo systemctl restart rslRO-wsproxy.service
sleep 1
echo Done.
