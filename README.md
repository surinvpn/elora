INSTALLER OPENSSH DROPBEAR OPENVPN STUNNEL WSTUNNEL SQUID3
PREQUISITE:
1. FRESH INSTALL UBUNTU 16.04
2. FRESH INSTALLATION THIS SCRIPT FROM [Angristan](https://github.com/angristan/openvpn-install). and do this
```bash
curl -O https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh
```
```sh
./openvpn-install.sh
```
-NB: must be using port 1194 tcp and client name: client

finish installation
------------------------------------------------------------------------------------------------------------------------------------------
NOW
1. Download installation script
```bash
wget https://github.com/malikshi/elora/releases/download/0.8/iptunnels.sh
chmod +x iptunnels.sh
./iptunnels.sh
```
2. see log installation
```sh
cat /root/log-install.txt
```
3. finishing, add some text to support firewall port 25000 udp for openvpn,
```sh
THIS SCRIPT DEDICATED TO IPTUNNELS.COM
```
