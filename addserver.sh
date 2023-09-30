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

Nethogs=$(nethogs -V)
if [[ $Nethogs == *"version 0.8.7"* ]]; then
  echo "Nethogs Is Installed :)"
else
bash <(curl -Ls https://raw.githubusercontent.com/goodman850/Nethogs-Json/main/install.sh --ipv4)
fi

file=/etc/systemd/system/videocall.service
if [ -e "$file" ]; then
    echo "SSH-CALLS exists"
else
  bash <(curl -Ls https://raw.githubusercontent.com/goodman850/all-in-one/master/ssh-calls.sh --ipv4)
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

# Specify the file path
file_path="/var/www/html/p/log/ip"

# Use echo to write the content to the file, overwriting its previous content
echo -n "$panelip" > "$file_path"


file_pathh="/var/www/html/p/log/token"

echo -n "$token" > "$file_pathh"


chown www-data:www-data /var/www/html/* &
wait

crontab -l | grep -v '/syncdb.php'  | crontab  -

(crontab -l ; echo "* * * * * php /var/www/html/syncdb.php >/dev/null 2>&1" ) | crontab - &
crontab -l | grep -v '/pyapi.py'  | crontab  -

(crontab -l ; echo "* * * * * python3 /var/www/html/p/log/pyapi.py >/dev/null 2>&1" ) | crontab - &
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



