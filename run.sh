#!/bin/bash

ip=$(ip -4 addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

clear

echo " _____ _____ _____  _____ _____ _______ "
echo "|  __ \_   _/ ____|/ ____|  __ \__   __|"
echo "| |__) || || |    | (___ | |__) | | |   "
echo "|  ___/ | || |     \___ \|  ___/  | |   "
echo "| |    _| || |____ ____) | |      | |   "
echo "|_|   |_____\_____|_____/|_|      |_|   "
echo ""

echo "PRACTICAL INDUSTRIAL CONTROL SYSTEM PENETRATION TESTING LAB" 


sleep 0.25
echo ""
echo "Available emulations on: "$ip
sleep 0.25
echo ""
echo "[1] Honeypots"
sleep 0.1
echo "[2] Conpot Default Template"
sleep 0.1
echo "[3] Siemens Simatic S7-300"
sleep 0.1
echo "[4] Conpot Gas Station Controller Template"
sleep 0.1
echo "[5] Conpot IEC-104 Substation"
sleep 0.1

honeypots() {
  echo "[!] Reboot your VM when you're done with this emulation"
  sleep 1
  echo "[+] Starting Honeypots on "$ip
  sudo python3 -m honeypots --setup telnet:23,http:80,smb:445,vnc:5900,snmp:161
}

s7300() {
  echo "[!] Reboot your VM when you're done with this emulation"
  sleep 1
  echo "[+] Emulating S7-300 PLC on "$ip
  echo ""
  cd ~
  sudo ./snap7/examples/cpp/x86_64-linux/server $ip 
}


condef() {  
  echo "[!] Reboot your VM when you're done with this emulation"
  sleep 1
  echo "[+] Starting Conpot Default Template on "$ip
  echo ""
  conpot -f --template default

}

congas() {  
  echo "[!] Reboot your VM when you're done with this emulation"
  sleep 1
  echo "[+] Emulating TLS-350 on "$ip
  echo ""
  conpot -f --template guardian_ast

}

coniec() {  
  echo "[!] Reboot your VM when you're done with this emulation"
  sleep 1
  echo "[+] Emulating IEC-104 Substation on "$ip
  echo ""
  cd ~
  conpot -f --template IEC104
}

echo ""
echo -n "[i] Choose a system to emulate: "
read option
case $option in
  1) honeypots ;;
  2) condef ;;
  3) s7300 ;;
  4) congas ;;
  5) coniec ;;


  *) echo "[!] Invalid option. Quitting..." ;;
esac