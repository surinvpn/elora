#!/bin/bash

#Requirement
if [ ! -e /usr/bin/curl ]; then
	apt-get -y update --fix-missing
	apt-get -y install curl git nano ufw stunnel4
fi

ufw allow OpenSSH
ufw allow 222/tcp
ufw allow 636/tcp
ufw allow 1194/tcp
ufw allow 443/tcp
ufw allow 10000/tcp
ufw allow 80/tcp
ufw allow 8080/tcp
ufw allow 3128/tcp
ufw allow 27015/udp
ufw allow 143/tcp
ufw allow 8530/tcp
ufw allow 2812/tcp
ufw allow 22507/tcp
ufw allow 444/tcp
ufw allow 8000/tcp
ufw allow 67
ufw allow 68
ufw allow 5353
ufw allow 1900
ufw allow 53/udp
ufw allow 25/udp
ufw allow 110/udp
ufw allow 54793
ufw allow 85
ufw allow 9000
ufw allow 7300
ufw allow 8888
ufw disable
sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
wget -O /etc/ufw/before.rules "https://github.com/malikshi/elora/raw/master/before.rules"
ufw enable -y
iptables -N BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: Bittorrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: BitTorrent protocol' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: peer_id=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: .torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: announce.php?passkey=' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: Torrent' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: announce' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'User-Agent: info_hash' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 80 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 80 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 22 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 22 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --sport 443 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'Host: playstation.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'Host: account.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'Host: auth.api.sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'Host: auth.api.np.ac.playstation.net' -j BLOCKACCESS
iptables -I INPUT -p tcp --dport 443 -m string --algo bm --string 'Host: sonyentertainmentnetwork.com' -j BLOCKACCESS
iptables -A BLOCKACCESS -j DROP
iptables -N BLOCKS
iptables -I INPUT -m string --algo bm --string 'BitTorrent' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'BitTorrent' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'BitTorrent' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'BitTorrent protocol' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'BitTorrent protocol' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'BitTorrent protocol' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'peer_id=' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'peer_id=' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'peer_id=' -j BLOCKS
iptables -I INPUT -m string --algo bm --string '.torrent' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string '.torrent' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string '.torrent' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'announce.php?passkey=' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'announce.php?passkey=' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'announce.php?passkey=' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'torrent' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'torrent' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'torrent' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'announce' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'announce' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'announce' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'info_hash' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'info_hash' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'info_hash' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'playstation' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'playstation' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'playstation' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'sonyentertainmentnetwork' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'sonyentertainmentnetwork' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'sonyentertainmentnetwork' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'account.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'account.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'account.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'auth.np.ac.playstation.net' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'auth.np.ac.playstation.net' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'auth.np.ac.playstation.net' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'auth.api.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'auth.api.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'auth.api.sonyentertainmentnetwork.com' -j BLOCKS
iptables -I INPUT -m string --algo bm --string 'auth.api.np.ac.playstation.ne' -j BLOCKS
iptables -I OUTPUT -m string --algo bm --string 'auth.api.np.ac.playstation.ne' -j BLOCKS
iptables -I FORWARD -m string --algo bm --string 'auth.api.np.ac.playstation.ne' -j BLOCKS
iptables -A BLOCKS -j DROP
iptables-save
apt-get -y install iptables-persistent
invoke-rc.d iptables-persistent save
