#!/bin/bash

---------------------------------------------------------------

echo -e "OS information: \n`lsb_release -dr`"
echo "----------------------------------"
echo "Motherboard Information:"
echo -e "`dmidecode -t 2 | grep Manufacturer`"
echo -e "`dmidecode -t 2 | grep 'Product Name'`"
echo "----------------------------------"
#echo -e "CPU Type: `cat /proc/cpuinfo | grep "model name" | cut -d: -f2`"
echo -e "CPU `cat /proc/cpuinfo | grep "model name" | uniq`"
echo -e "Physical Count: `cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l`"
echo -e "Total Logical Cores: `cat /proc/cpuinfo | grep "model name" | wc -l`"
echo "----------------------------------"
echo -e "Memory: `free -m | grep Mem | awk '{print $2}'` MB"
echo -e "Swap: `free -m | grep Swap | awk '{print $2}'` MB"
echo "----------------------------------"
echo -e "Hard Drive(s): \n`fdisk -l | grep Disk | grep -v ident`"
echo "----------------------------------"
echo -e "Power On: \n`smartctl -a /dev/sda | grep Power_On_Hours`"
echo "----------------------------------"
echo -e "Disk Firmware Info: \n`smartctl -a /dev/sda | grep Model && smartctl -a /dev/sda | grep Firmware &&  dmesg | grep -i sata | grep 'link up'`"
echo "----------------------------------"
echo -e "Partition information: \n`df -h`"
echo "----------------------------------"
tw_cli info | egrep "^c" | while read controller; do
   c=($controller); cn=${c[0]}; model=${c[1]};
   echo "Controller {$cn} ({$model}):"

   tw_cli info $cn | egrep "^u" | while read unit; do
      u=($unit); un=${u[0]}; type=${u[1]}; ustatus=${u[2]}; usize=${u[6]};
      echo -e "\tunit $un -- $usize $type (status: $ustatus)";

      tw_cli info $cn $un | grep DISK | while read disk; do
         d=($disk); port=${d[5]}; dstatus=${d[2]}; dsize=${d[7]};
         echo -e "\t\tdisk $port -- $dsize (status: $dstatus)"
      done
   done
done
echo -e "`tw_cli /c0/u0 show cache ; tw_cli /c4/u0 show cache ; tw_cli /c0/u1 show cache ; tw_cli /c4/u1 show cache`"
echo -e "`tw_cli /c0 show firmware ; tw_cli /c4 show firmware`"
echo "----------------------------------"
echo -e "IP Addresses: \n`ip addr | grep "inet " | grep -v "127.0.0.1" | cut -d" " -f 6,11-12`";
echo "----------------------------------"
echo "Resolvers"
cat /etc/resolv.conf
echo "----------------------------------"
echo -e "Network Speed:"
if [ -f /sbin/ethtool ]
then
echo -e "Eth0`ethtool eth0 | grep Speed`"
echo -e "Eth1`ethtool eth1 | grep Speed`"
else
echo -e "Ethtool is not installed."
fi
echo "----------------------------------"
echo "Checking cPanel licenses......"
if [ -f /usr/local/cpanel/cpkeyclt ]
then
/usr/local/cpanel/cpkeyclt
echo -e "cPanel main IP: `cat /var/cpanel/mainip`"
else
echo "Not a cPanel server."
fi
