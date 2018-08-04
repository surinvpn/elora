#!/bin/bash

#Requirement
if [ ! -e /usr/bin/curl ]; then
	apt-get -y update --fix-missing
	apt-get -y install curl git nano stunnel4
fi

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
