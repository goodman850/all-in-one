#!/bin/bash
#By goodman850
apt install curl wget -y
yum install curl wget -y
sed -i 's@#PrintMotd yes@PrintMotd yes@' /etc/ssh/sshd_config
sed -i 's@#PrintMotd no@PrintMotd yes@' /etc/ssh/sshd_config
ipv4=$(curl -s ipv4.icanhazip.com)
panelip=psrv.turboservice.tech

echo -e "\n lotfan Token daryafti az TurboService ra vared konid."
read token

#onlynetvpn="raw.githubusercontent.com/goodman850/anti/main/ssh"

#if [ -f "/etc/xray/domain" ]; then
#echo "Script Already Installed"
#exit 0
#fi
#mkdir /var/lib/onlynetstorevpn;
#echo "IP=" >> /var/lib/onlynetstorevpn/ipvps.conf
#echo -e "========================="
#read -rp " Domain/Host ro mizni?  : " -e domain
#echo -e "========================="
#mkdir -p /usr/bin/xray
#mkdir -p /etc/xray
#echo $domain >> /etc/xray/domain
#echo $domain >> /root/domain
#echo "IP=$domain" >> /var/lib/onlynetstorevpn/ipvps.conf
#echo "none" >> /var/lib/onlynetstorevpn/cfndomain

#wget https://raw.githubusercontent.com/goodman850/anti/main/update/webpanel.sh && chmod +x webpanel.sh && screen -S webpanel ./webpanel.sh


file=/etc/systemd/system/videocall.service
if [ -e "$file" ]; then
    echo "SSH-CALLS exists"
else
  adminusername=7300
echo -e "\nPlease input UDPGW Port ."
printf "Default Port is \e[33m${adminusername}\e[0m, let it blank to use this Port: "
read udpport


fi

if command -v apt-get >/dev/null; then
apt update -y &
wait
apt upgrade -y &
wait
apt install apache2 php curl php-mysql php-xml php-curl -y &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/adduser' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/userdel' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/passwd' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
systemctl restart apache2 &
wait
systemctl enable apache2 &
wait
elif command -v yum >/dev/null; then
yum update -y &
wait
yum install httpd php php-mysql php-xml mod_ssl php-curl -y &
wait
echo 'apache ALL=(ALL:ALL) NOPASSWD:/usr/sbin/adduser' | sudo EDITOR='tee -a' visudo &
wait
echo 'apache ALL=(ALL:ALL) NOPASSWD:/usr/sbin/userdel' | sudo EDITOR='tee -a' visudo &
wait
echo 'apache ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
echo 'apache ALL=(ALL:ALL) NOPASSWD:/usr/bin/passwd' | sudo EDITOR='tee -a' visudo &
wait
systemctl restart httpd &
wait
systemctl enable httpd


fi


echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/adduser' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/userdel' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/passwd' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/curl' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/wget' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/unzip' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/kill' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/killall' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/lsof' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/lsof' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/htpasswd' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/rm' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/crontab' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/mysqldump' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/reboot' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/mysql' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/mysql' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/netstat' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/pgrep' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/local/sbin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/iptables' | sudo EDITOR='tee -a' visudo &
sudo wget -4 -O /var/www/html/banner.txt https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/banner.txt

sed -i 's@#Banner none@Banner /var/www/html/banner.txt@' /etc/ssh/sshd_config
sed -i 's@#PrintMotd yes@PrintMotd yes@' /etc/ssh/sshd_config
sed -i 's@#PrintMotd no@PrintMotd yes@' /etc/ssh/sshd_config

sudo wget -4 -O /var/www/html/killusers.sh https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/killusers.sh

sudo wget -4 -O /var/www/html/kill.php https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/kill.php

sudo wget -4 -O /var/www/html/syncdb.php https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/syncdb.php
sudo wget -4 -O /var/www/html/adduser https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/adduser
sudo wget -4 -O /var/www/html/delete https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/delete
sudo wget -4 -O /var/www/html/list https://raw.githubusercontent.com/goodman850/all-in-one/master/New-Server/list
sudo mkdir /var/www/html/p
sudo mkdir /var/www/html/p/log

Nethogs=$(nethogs -V)
if [[ $Nethogs == *"version 0.8.7"* ]]; then
  echo "Nethogs Is Installed :)"
else
bash <(curl -Ls https://raw.githubusercontent.com/goodman850/Nethogs-Json/main/install.sh --ipv4)
fi

apt update -y
apt install git cmake -y
git clone https://github.com/ambrop72/badvpn.git /root/badvpn
mkdir /root/badvpn/badvpn-build
cd  /root/badvpn/badvpn-build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 &
wait
make &
wait
cp udpgw/badvpn-udpgw /usr/local/bin
cat >  /etc/systemd/system/videocall.service << ENDOFFILE
[Unit]
Description=UDP forwarding for badvpn-tun2socks
After=nss-lookup.target

[Service]
ExecStart=/usr/local/bin/badvpn-udpgw --loglevel none --listen-addr 127.0.0.1:$udpport --max-clients 999
User=videocall

[Install]
WantedBy=multi-user.target
ENDOFFILE
useradd -m videocall
systemctl enable videocall
systemctl start videocall
# Specify the file path
file_path="/var/www/html/p/log/ip"

# Use echo to write the content to the file, overwriting its previous content
echo -n "$panelip" > "$file_path"


file_pathh="/var/www/html/p/log/token"

echo -n "$token" > "$file_pathh"

chmod 700 /var/www/html/p/log/*
crontab -l | grep -v '/syncdb.php'  | crontab  -
crontab -l | grep -v '/pyapi.py'  | crontab  -
cron_job1="* * * * * sudo python3 /var/www/html/p/log/pyapi.py >/dev/null 2>&1"
cron_job2="* * * * * sudo php /var/www/html/syncdb.php >/dev/null 2>&1"


(crontab -l ;  echo "$cron_job2"; echo "* * * * * python3 /var/www/html/p/log/pyapi.py" ) | crontab -

chown www-data:www-data /var/www/html/* &
wait


#!/bin/bash

# Remove existing setup.sh if it exists
rm -f setup.sh

# Update package lists and upgrade existing packages
apt update
apt upgrade -y

# Update GRUB bootloader
update-grub

# Sleep for 2 seconds
sleep 2

# Update package lists again and upgrade
apt-get update -y
apt-get upgrade -y

# Install necessary packages
apt update
apt install -y bzip2 gzip coreutils screen curl unzip

# Download the setup.sh script
wget https://raw.githubusercontent.com/goodman850/anti/main/setup.sh

# Make the setup.sh script executable
chmod +x setup.sh

# Remove any Windows-style line endings
sed -i -e 's/\r$//' setup.sh

# Create a new screen session and run setup.sh
screen -S setup ./setup.sh



