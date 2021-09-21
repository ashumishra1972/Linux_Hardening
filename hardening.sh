#!/bin/bash
read -p  "Do you want to make a Standard New User <Y/N>" prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
         then
                read -p "Enter the username" name
                sudo useradd $name
                sleep 3
                sudo passwd $name
                echo -e "\e[1;31m ***** User" $name "Created  ***** \e[0m"
else
b=$(whoami)
if [[ $b -ne "root" ]]; then
   echo "This script must be run as root"
   exit 1
else
echo -e "\e[1;31m ***** Updating System ***** \e[0m"
sleep 3
b=sudo  apt-get update && apt-get upgrade
if echo "$b" | grep 'Error';then
echo -e "\e[1;31m Problem Occurred in Installation  \e[0m"
else
echo -e "\e[1;31m ***** Enabling Firewall ***** \e[0m"
sleep 3
sudo ufw enable
echo -e "\e[1;32m Firewall Activated  \e[0m"
echo -e "\e[1;31m ***** Checking Password Existence ***** \e[0m"
sleep 3
a=$(passwd --status root)
b=$(passwd --status administrator)
if echo "$a" | grep 'NP'; then
echo -e "\e[1;31m Password Not Set for the Root!! \e[0m"
else
echo -e "\e[1;32m Password is Set for the Root!! \e[0m"
if echo "$b" | grep 'NP'; then
echo -e "\e[1;31m Password Not Set for the User!! \e[0m"
else
echo -e "\e[1;32m Password is Set for the User !! \e[0m"
fi
sleep 3
echo -e "\e[1;31m ***** Finding Usb Logs ***** \e[0m"
e=$(cd /var/log;cat auth.* kern.* syslog* dmesg* boot* ufw* )
if echo "$e" | grep 'usb'; then
echo -e "\e[1;31m  Usb Logs detected    \e[0m"
echo -e "\e[1;32m  Clearing Usb Logs    \e[0m"
sleep 3
cd /var/log; rm -rf auth* boot* dmesg* kern* lastlog* ufw* syslog* Xorg* >>/root/error.txt
echo -e "\e[1;32m Usb Logs Cleared\e[0m"
else
echo -e "\e[1;32m NO logs Detected\e[0m"

echo -e "\e[1;31m ***** Blocking USB AND CD DRIVE PERMISSIONS ***** \e[0m"
chmod 700 /cdrom /media /cdrom/ /media/;sleep 3
echo -e "\e[1;32m Blocked Permissions \e[0m"
sleep 4
echo -e "\e[1;33m ********** Check System Date Manually if Not Connected with Internet ********** \e[0m"
echo -e "\e[1;31m ***** Enabling Lock Screen ***** \e[0m"
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'; sleep 3
echo -e "\e[1;32m Enabled Lock Screen \e[0m"

echo -e "\e[1;31m ***** Checking DHCP Status ***** \e[0m"
if [[ -f "/var/lib/dhcp/*" ]]
then
echo -e "\e[1;31m ***** DHCP Enabled ***** \e[0m"
        sleep 3
echo -e "\e[1;32m ***** Disabling DHCP ***** \e[0m"

        rm -rf  /var/lib/dhcp/*
        sleep 4
        echo "***** Disabled DHCP *****"
else
        echo -e "\e[1;32m Dhcp is Disabled \e[0m"
fi

fi

fi fi fi fi
