INSTALLER OPENSSH DROPBEAR OPENVPN STUNNEL WSTUNNEL SQUID3
PREQUISITE:
1. FRESH INSTALL UBUNTU 14.04
2. FRESH INSTALLATION THIS SCRIPT FROM Nyr openvpn-install do "wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh"

NOW
1. SETUP firewall
``bash
	wget https://github.com/malikshi/elora/raw/master/ready.sh --no-check-certificate
	wget https://github.com/malikshi/elora/raw/master/requirment.sh --no-check-certificate
	wget https://github.com/malikshi/elora/raw/master/readySSH.sh --no-check-certificate
	chmod +x ready.sh
	chmod +x readySSH.sh
	chmod +x requirment.sh
	sed -i -e 's/\r$//' requirment.sh
	sed -i -e 's/\r$//' ready.sh
	sed -i -e 's/\r$//' readySSH.sh
	./requirment.sh
```
2. do this script

	./ready.sh
  
3. finishing, add some text to support firewall port 25000 udp for openvpn,

	nano /etc/rc.local
	iptables -I FORWARD -s 10.9.0.0/24 -j ACCEPT
	iptables -I INPUT -p udp --dport 25000 -j ACCEPT
	iptables -t nat -A POSTROUTING -s 10.9.0.0/24 ! -d 10.9.0.0/24 -j SNAT --to 163.44.159.88
