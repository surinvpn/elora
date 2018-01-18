#!/bin/bash

#Requirement
if [ ! -e /usr/bin/curl ]; then
    apt-get -y update --fix-missing && apt-get -y upgrade
	apt-get -y install curl git nano ufw stunnel4
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(curl -4 icanhazip.com)
if [ $MYIP = "" ]; then
   MYIP=`ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1`;
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";

#check jika script sudah pernah diinput
scriptname='sshvpn';
mkdir -p /var/lib/setup-log
echo " " >> /var/lib/setup-log/setup.txt
scriptchecker=`cat /var/lib/setup-log/setup.txt | grep $scriptname`;
if [ "$scriptchecker" != "" ]; then
		clear
		echo -e " ";
		echo -e "Error! Anda sudah pernah memasukkan script ini sebelumnya";
		echo -e "Script ini hanya bisa diinstall 1x saja biar ga eror!";
		echo -e "---";
		echo -e "Jika Anda sebelumnya gagal dalam instalasi, Mohon untuk reinstall OS VPS Anda lebih dulu!";
		echo -e "Anda dapat mereinstall OS VPS atau menghapus script yang pernah diinstall";
		echo -e " ";
        exit 0;
	else
		echo "";
fi
echo "$scriptname" >> /var/lib/setup-log/setup.txt

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#Add DNS Server ipv4
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
sed -i '$ i\echo "nameserver 8.8.8.8" > /etc/resolv.conf' /etc/rc.local
sed -i '$ i\echo "nameserver 8.8.4.4" >> /etc/resolv.conf' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
cat > /etc/apt/sources.list <<END2
deb http://cdn.debian.net/debian wheezy main contrib non-free
deb http://security.debian.org/ wheezy/updates main contrib non-free
deb http://packages.dotdeb.org wheezy all
END2
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;
apt-get -y purge sendmail*
apt-get -y remove sendmail*

# update
apt-get update; apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install essential package
echo "mrtg mrtg/conf_mods boolean true" | debconf-set-selections
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off
# update apt-file
apt-file update
# setting vnstat
vnstat -u -i venet0
service vnstat restart

# install screenfetch
cd
wget -O /usr/bin/screenfetch "https://github.com/malikshi/elora/raw/master/screenfetch"
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch" >> .profile

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
cat > /etc/nginx/nginx.conf <<END3
user www-data;

worker_processes 1;
pid /var/run/nginx.pid;

events {
	multi_accept on;
  worker_connections 1024;
}

http {
	gzip on;
	gzip_vary on;
	gzip_comp_level 5;
	gzip_types    text/plain application/x-javascript text/xml text/css;

	autoindex on;
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  server_tokens off;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;
  client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_header_buffers 8 8m;

	fastcgi_buffer_size 8m;
	fastcgi_buffers 8 8m;

	fastcgi_read_timeout 600;

  include /etc/nginx/conf.d/*.conf;
}
END3
mkdir -p /home/vps/public_html
wget -O /home/vps/public_html/index.html "http://script.hostingtermurah.net/repo/index.html"
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
args='$args'
uri='$uri'
document_root='$document_root'
fastcgi_script_name='$fastcgi_script_name'
cat > /etc/nginx/conf.d/vps.conf <<END4
server {
  listen       85;
  server_name  127.0.0.1 localhost;
  access_log /var/log/nginx/vps-access.log;
  error_log /var/log/nginx/vps-error.log error;
  root   /home/vps/public_html;

  location / {
    index  index.html index.htm index.php;
    try_files $uri $uri/ /index.php?$args;
  }

  location ~ \.php$ {
    include /etc/nginx/fastcgi_params;
    fastcgi_pass  127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
  }
}

END4
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart


#install OpenVPN
apt-get -y install openvpn iptables openssl
cp -R /usr/share/doc/openvpn/examples/easy-rsa/ /etc/openvpn
# easy-rsa
if [[ ! -d /etc/openvpn/easy-rsa/2.0/ ]]; then
	wget --no-check-certificate -O ~/easy-rsa.tar.gz https://github.com/OpenVPN/easy-rsa/archive/2.2.2.tar.gz
    tar xzf ~/easy-rsa.tar.gz -C ~/
    mkdir -p /etc/openvpn/easy-rsa/2.0/
    cp ~/easy-rsa-2.2.2/easy-rsa/2.0/* /etc/openvpn/easy-rsa/2.0/
    rm -rf ~/easy-rsa-2.2.2
    rm -rf ~/easy-rsa.tar.gz
fi
cd /etc/openvpn/easy-rsa/2.0/
# benarkan errornya
cp -u -p openssl-1.0.0.cnf openssl.cnf
# ganti bits
sed -i 's|export KEY_SIZE=1024|export KEY_SIZE=2048|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_COUNTRY="US"|export KEY_COUNTRY="ID"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_PROVINCE="CA"|export KEY_PROVINCE="DIY"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_CITY="SanFrancisco"|export KEY_CITY="Yogyakarta"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_ORG="Fort-Funston"|export KEY_ORG="www.globalssh.net"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_EMAIL="me@myhost.mydomain"|export KEY_EMAIL="admin@globalssh.net"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_EMAIL=mail@host.domain|export KEY_EMAIL=admin@globalssh.net|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_OU=changeme|export KEY_OU=GlobalSSH|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_CN=changeme|export KEY_CN="GlobalSSH"|' /etc/openvpn/easy-rsa/2.0/vars
sed -i 's|export KEY_NAME=changeme|export KEY_NAME=globalssh.net|' /etc/openvpn/easy-rsa/2.0/vars
# Buat PKI
. /etc/openvpn/easy-rsa/2.0/vars
. /etc/openvpn/easy-rsa/2.0/clean-all
# Buat Sertifikat
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" --initca $*
# buat key server
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" --server server
# seting KEY CN
export EASY_RSA="${EASY_RSA:-.}"
"$EASY_RSA/pkitool" client
# DH params
. /etc/openvpn/easy-rsa/2.0/build-dh
# Setting Server
cat > /etc/openvpn/server.conf <<-END5
port 1194
proto tcp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 192.168.100.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-vpn.log
verb 3
END5

cat > /etc/openvpn/udp25.conf <<-END6
port 25
proto udp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-vpn.log
verb 3
END6

cat > /etc/openvpn/udpssl53.conf <<-END7
port 53
proto udp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.9.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-vpn.log
verb 3
END7

sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
cd /etc/openvpn/easy-rsa/2.0/keys
cp ca.crt ca.key dh2048.pem server.crt server.key /etc/openvpn
cd /etc/openvpn/

# Restart openvpn
/etc/init.d/openvpn restart

#Create OpenVPN Config
mkdir -p /home/vps/public_html
cat > /home/vps/public_html/client.ovpn <<-END8
# OpenVPN Configuration GlobalSSH Server
# (Official @www.globalssh.net)
client
proto tcp
persist-key
persist-tun
dev tun
pull
comp-lzo
ns-cert-type server
verb 3
mute 2
mute-replay-warnings
auth-user-pass
redirect-gateway def1
script-security 2
route 0.0.0.0 0.0.0.0
route-method exe
route-delay 2
remote $MYIP 1194
cipher AES-128-CBC
END8
echo '<ca>' >> /home/vps/public_html/client.ovpn
cat /etc/openvpn/ca.crt >> /home/vps/public_html/client.ovpn
echo '</ca>' >> /home/vps/public_html/client.ovpn
cd /home/vps/public_html/
tar -czf /home/vps/public_html/openvpn.tar.gz client.ovpn
tar -czf /home/vps/public_html/client.tar.gz client.ovpn
cd

# set ipv4 forward
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|' /etc/sysctl.conf
sed -i 's|net.ipv4.ip_forward=0|net.ipv4.ip_forward=1|' /etc/sysctl.conf

#tcpfastopen
echo "3" > /proc/sys/net/ipv4/tcp_fastopen
echo "net.ipv4.tcp_fastopen=3" > /etc/sysctl.d/30-tcp_fastopen.conf
echo '* soft nofile 51200' >> /etc/security/limits.conf
echo '* hard nofile 51200' >> /etc/security/limits.conf
wget -O /etc/sysctl.d/local.conf "https://github.com/malikshi/elora/raw/master/local.conf"
wget -O /etc/issue.net "https://github.com/malikshi/elora/raw/master/issue.net"
ulimit -n 51200
sysctl --system
sysctl -p /etc/sysctl.d/local.conf

#swap ram
echo 'vm.swappiness= 40' >>/etc/sysctl.conf
echo 'vm.vfs_cache_pressure = 50' >>/etc/sysctl.conf
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >>/etc/fstab
sudo sysctl vm.swappiness=40
sudo sysctl vm.vfs_cache_pressure=50
sudo swapon -s
clear

# install badvpn
wget -O /usr/bin/badvpn-udpgw "https://github.com/malikshi/elora/raw/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://github.com/malikshi/elora/raw/master/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install mrtg
wget -O /etc/snmp/snmpd.conf "https://github.com/malikshi/elora/raw/master/snmpd.conf"
wget -O /root/mrtg-mem.sh "https://github.com/malikshi/elora/raw/master/mrtg-mem.sh"
chmod +x /root/mrtg-mem.sh
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl "https://github.com/malikshi/elora/raw/master/mrtg.conf" >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

#install ssh
echo 'MaxAuthTries 2' >>/etc/ssh/sshd_config
echo 'Banner /etc/issue.net' >>/etc/ssh/sshd_config

# install dropbear
cd
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 80"/g' /etc/default/dropbear
sed -i 's/DROPBEAR_BANNER=""/DROPBEAR_BANNER="/etc/issue.net"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

#Upgrade to Dropbear 2016
cd
apt-get install zlib1g-dev
wget https://matt.ucc.asn.au/dropbear/dropbear-2017.75.tar.bz2
bzip2 -cd dropbear-2017.75.tar.bz2 | tar xvf -
cd dropbear-2017.75
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear.old
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
cd && rm -rf dropbear-2017.75 && rm -rf dropbear-2017.75.tar.bz2
service dropbear restart

#install stunnel4
cd
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
sed -i $MYIP2 /etc/stunnel/stunnel.conf;

# install vnstat gui
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i 's/eth0/venet0/g' config.php
sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
service fail2ban restart
cd

# install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://github.com/malikshi/elora/raw/master/squid.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart


# install webmin
cd
echo 'deb http://download.webmin.com/download/repository sarge contrib' >>/etc/apt/sources.list
echo 'deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib' >>/etc/apt/sources.list
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get -y update && apt-get -y install webmin

#autoban & filtering
cd
sed -i '$ i\screen -AmdS limit /root/limit.sh' /etc/rc.local
sed -i '$ i\screen -AmdS ban /root/ban.sh' /etc/rc.local
sed -i '$ i\screen -AmdS limit /root/limit.sh' /etc/rc.d/rc.local
sed -i '$ i\screen -AmdS ban /root/ban.sh' /etc/rc.d/rc.local
echo 'service fail2ban restart' >> /etc/rc.local
echo 'service dropbear restart' >> /etc/rc.local
echo 'sudo service squid3 restart' >> /etc/rc.local
echo '/etc/init.d/dropbear restart' >> /etc/rc.local
echo 'service dropbear restart' >> /etc/rc.local
echo "0 0 * * * root /usr/local/bin/user-expire" > /etc/cron.d/user-expire
cd

cat > /root/ban.sh <<END9
#!/bin/bash
#/usr/local/bin/user-ban
END9

cat > /root/limit.sh <<END10
#!/bin/bash
#/usr/local/bin/user-limit
END10

cd /usr/local/bin
wget -O premium-script.tar.gz "https://github.com/malikshi/elora/raw/master/premium-script.tar.gz"
tar -xvf premium-script.tar.gz
rm -f premium-script.tar.gz

cp /usr/local/bin/premium-script /usr/local/bin/menu

chmod +x /usr/local/bin/trial
chmod +x /usr/local/bin/user-add
chmod +x /usr/local/bin/user-aktif
chmod +x /usr/local/bin/user-ban
chmod +x /usr/local/bin/user-delete
chmod +x /usr/local/bin/user-detail
chmod +x /usr/local/bin/user-expire
chmod +x /usr/local/bin/user-limit
chmod +x /usr/local/bin/user-lock
chmod +x /usr/local/bin/user-login
chmod +x /usr/local/bin/user-unban
chmod +x /usr/local/bin/user-unlock
chmod +x /usr/local/bin/user-password
chmod +x /usr/local/bin/user-log
chmod +x /usr/local/bin/user-add-pptp
chmod +x /usr/local/bin/user-delete-pptp
chmod +x /usr/local/bin/alluser-pptp
chmod +x /usr/local/bin/user-login-pptp
chmod +x /usr/local/bin/user-expire-pptp
chmod +x /usr/local/bin/user-detail-pptp
chmod +x /usr/local/bin/bench-network
chmod +x /usr/local/bin/speedtest
chmod +x /usr/local/bin/ram
chmod +x /usr/local/bin/log-limit
chmod +x /usr/local/bin/log-ban
chmod +x /usr/local/bin/listpassword
chmod +x /usr/local/bin/pengumuman
chmod +x /usr/local/bin/user-generate
chmod +x /usr/local/bin/user-list
chmod +x /usr/local/bin/diagnosa
chmod +x /usr/local/bin/premium-script
chmod +x /usr/local/bin/user-delete-expired
chmod +x /usr/local/bin/auto-reboot
chmod +x /usr/local/bin/log-install
chmod +x /usr/local/bin/menu
chmod +x /usr/local/bin/user-auto-limit
chmod +x /usr/local/bin/user-auto-limit-script
chmod +x /usr/local/bin/edit-port
chmod +x /usr/local/bin/edit-port-squid
chmod +x /usr/local/bin/edit-port-openvpn
chmod +x /usr/local/bin/edit-port-openssh
chmod +x /usr/local/bin/edit-port-dropbear
chmod +x /usr/local/bin/autokill
chmod +x /root/limit.sh
chmod +x /root/ban.sh
screen -AmdS limit /root/limit.sh
screen -AmdS ban /root/ban.sh
clear
cd

# finalisasi
chown -R www-data:www-data /home/vps/public_html
service nginx start
service php5-fpm start
service vnstat restart
service openvpn restart
service snmpd restart
service ssh restart
service dropbear restart
service fail2ban restart
service squid3 restart
service webmin restart
#clearing history
history -c

# info
clear
echo " "
echo "Instalasi telah selesai! Mohon baca dan simpan penjelasan setup server!"
echo " "
echo "--------------------------- Penjelasan Setup Server ----------------------------"
echo "            Modified by https://www.facebook.com/ibnumalik.al                   "
echo "--------------------------------------------------------------------------------"
echo ""  | tee -a log-install.txt
echo "Informasi Server"  | tee -a log-install.txt
echo "   - Timezone    : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban    : [on]"  | tee -a log-install.txt
echo "   - IPtables    : [off]"  | tee -a log-install.txt
echo "   - Auto-Reboot : [on]"  | tee -a log-install.txt
echo "   - IPv6        : [off]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Informasi Aplikasi & Port"  | tee -a log-install.txt
echo "   - OpenVPN     : TCP 1194 UDP 25 UDP SSL 53"  | tee -a log-install.txt
echo "   - OpenSSH     : 22"  | tee -a log-install.txt
echo "   - OpenSSH-SSL : 444"  | tee -a log-install.txt
echo "   - Dropbear    : 143, 80"  | tee -a log-install.txt
echo "   - Dropbear-SSL: 443, 54793"  | tee -a log-install.txt
echo "   - Squid Proxy : 8000 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Squid-SSL   : 8080,3128 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn      : 7300"  | tee -a log-install.txt
echo "   - Nginx       : 85"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Informasi Tools Dalam Server"  | tee -a log-install.txt
echo "   - htop"  | tee -a log-install.txt
echo "   - iftop"  | tee -a log-install.txt
echo "   - mtr"  | tee -a log-install.txt
echo "   - nethogs"  | tee -a log-install.txt
echo "   - screenfetch"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Informasi Premium Script"  | tee -a log-install.txt
echo "   Perintah untuk menampilkan daftar perintah: menu"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   Penjelasan script dan setup VPS"| tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Informasi Penting"  | tee -a log-install.txt
echo "   - Download Config OpenVPN : http://$MYIP:85/client.ovpn"  | tee -a log-install.txt
echo "     Mirror (*.tar.gz)       : http://$MYIP:85/openvpn.tar.gz"  | tee -a log-install.txt
echo "   - Webmin                  : http://$MYIP:10000/"  | tee -a log-install.txt
echo "   - Vnstat                  : http://$MYIP:85/vnstat/"  | tee -a log-install.txt
echo "   - MRTG                    : http://$MYIP:85/mrtg/"  | tee -a log-install.txt
echo "   - Log Instalasi           : cat /root/log-install.txt"  | tee -a log-install.txt
echo "     NB: User & Password Webmin adalah sama dengan user & password root"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "            Modified by https://www.facebook.com/ibnumalik.al                   "
