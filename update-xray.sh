#!/bin/bash
#By goodman850
# Make Folder XRay
domain=$(cat /etc/xray/domain)
mkdir -p /var/log/xray/
touch /var/log/xray/access.log
touch /var/log/xray/error.log
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd /root/
wget https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
bash acme.sh --install
rm acme.sh
cd .acme.sh
bash acme.sh --register-account -m vppturss1@gmail.com
bash acme.sh --issue --standalone -d $domain --force
bash acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key
service squid start
#new coming

uuid=$(cat /proc/sys/kernel/random/uuid)
# //

# // Certificate File
path_crt="/etc/xray/xray.crt"
path_key="/etc/xray/xray.key"
rm -rf /etc/xray/config.json
touch /etc/xray/config.json

cat >/etc/xray/config.json <<END
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
"listen": "127.0.0.1",
"port": 10085,
"protocol": "dokodemo-door",
"settings": {
"address": "127.0.0.1"
},
"tag": "api",
"sniffing": null
},

{
  "listen": "0.0.0.0",
      "port": 8443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid3}"

          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "${path_crt}",
              "keyFile": "${path_key}"
            }
          ]
        },
        
        "wsSettings": {
          "path": "/vless/",
          "headers": {
            "Host": "$domain"
          }
        }
        
      },
      
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": "0.0.0.0",
      "port": 80,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${uuid4}"

          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/vless/",
          "headers": {
            "Host": "$domain"
          }
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      }
    },
    {
      "listen": "0.0.0.0",
      "port": 2087,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "${uuid5}"

          }
        ],
        "fallbacks": [
          {
            "dest": "$domain:80"
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "${path_crt}",
              "keyFile": "${path_key}"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      }
      
     },
     {
            "listen": "0.0.0.0",
            "port": 2053,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "email": "general@vless-tcp-xtls",
                        "id": "9f2b4b10-6818-492e-a157-d5131d450c7b",
                        "flow": "xtls-rprx-vision",
                        "level": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "dest": "zula.ir:443",
                    "xver": 0,
                    "serverNames": [
                        "zula.ir",
						 "www.zula.ir"
                    ],
                    "privateKey": "M4cZLR81ErNfxnG1fAnNUIATs_UXqe6HR78wINhH7RA",
                    "minClientVer": "",
                    "maxClientVer": "",
                    "maxTimeDiff": 0,
                    "shortIds": [
                        "b1"
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls"
                ]
            }
        }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
"HandlerService",
"LoggerService",
"StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
     "statsInboundUplink": true,
"statsInboundDownlink": true,
"statsOutboundUplink": true,
"statsOutboundDownlink": true
    }
  }
}
END

# // Enable & Start Service
# Accept port Xray
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2087 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2053 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2053 -j ACCEPT
iptables-save >/etc/iptables.up.rules
iptables-restore -t </etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl stop xray.service
systemctl start xray.service
systemctl enable xray.service
systemctl restart xray.service

#END new