#!/bin/bash
# Requirements
sudo apt-get -y update
sudo apt-get -y install strongswan xl2tpd libstrongswan-standard-plugins libstrongswan-extra-plugins

sleep 1

sudo bash -c 'cat > /etc/ipsec.conf <<EOF
config setup
conn %default
    ikelifetime=60m
    keylife=20m
    rekeymargin=3m
    keyingtries=1
    keyexchange=ikev1
    authby=secret
 
conn rslRO
    keyexchange=ikev1
    left=%defaultroute
    auto=add
    ike="aes128-sha1-modp2048,3des-sha1-modp1536"
    esp="aes128-sha1,3des-sha1"
    authby=secret
    type=transport
    leftprotoport=17/1701
    rightprotoport=17/1701
    right=45.64.96.131
EOF'
sleep 1
sudo bash -c 'cat > /etc/ipsec.secrets <<EOF
45.64.96.131 : PSK "okevpnku"
EOF'
sudo chmod 600 /etc/ipsec.secrets
sleep 1
sudo bash -c 'cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[lac rslRO]
lns = 45.64.96.131
ppp debug = yes
pppoptfile = /etc/ppp/options.rslRO.l2tpd
length bit = yes
EOF
cat > /etc/ppp/options.rslRO.l2tpd <<EOF
ipcp-accept-local
ipcp-accept-remote
refuse-eap
require-chap
noccp
noauth
mtu 1280
mru 1280
noipdefault
defaultroute
usepeerdns
connect-delay 5000
name rijal
password rijal@123
EOF'
sudo chmod 600 /etc/ppp/options.rslRO.l2tpd
sleep 1
sudo service strongswan restart
sudo service xl2tpd restart
sudo bash -c 'cat > /usr/local/bin/start-vpn <<EOF
#!/bin/bash
(service strongswan start ;
sleep 2 ;
service xl2tpd start) && (
ipsec up rslRO
echo "c rslRO" > /var/run/xl2tpd/l2tp-control
sleep 5
#ip route add 10.0.0.0/24 dev ppp0
)
EOF'
sudo chmod +x /usr/local/bin/start-vpn
sleep 1
sudo bash -c 'cat > /usr/local/bin/stop-vpn <<EOF
#!/bin/bash
(sudo echo "d rslRO" > /var/run/xl2tpd/l2tp-control
sudo ipsec down rslRO) && (
sudo service xl2tpd stop ;
sudo service strongswan stop)
EOF'
sudo chmod +x /usr/local/bin/stop-vpn
sleep 1
echo "To start VPN type: start-vpn"
echo "To stop VPN type: stop-vpn"
