{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 ArialMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 #!/bin/bash
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2 echo "Resetting IPMI to firmware defaults";
\f1\fs24 \

\f0\fs29\fsmilli14667 /usr/sbin/ipmicfg -fd
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Waiting 80 seconds...please be patient!"
\f1\fs24 \

\f0\fs29\fsmilli14667 sleep 80
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Card has been reset!"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Configuring IPMI to IP **ipmiip**"
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2 /usr/sbin/ipmicfg -dhcp off
\f1\fs24 \

\f0\fs29\fsmilli14667 /usr/sbin/ipmicfg -m **ipmiip**
\f1\fs24 \

\f0\fs29\fsmilli14667 /usr/sbin/ipmicfg -k **ipminetmask**
\f1\fs24 \

\f0\fs29\fsmilli14667 /usr/sbin/ipmicfg -g **ipmigateway**
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2 echo "IPMI shits configured"
\f1\fs24 \

\f0\fs29\fsmilli14667 ---------------------------------------------------------------
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2 echo -e "OS information: \\n`lsb_release -dr`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Motherboard Information:"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "`dmidecode -t 2 | grep Manufacturer`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "`dmidecode -t 2 | grep 'Product Name'`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 #echo -e "CPU Type: `cat /proc/cpuinfo | grep "model name" | cut -d: -f2`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "CPU `cat /proc/cpuinfo | grep "model name" | uniq`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Physical Count: `cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Total Logical Cores: `cat /proc/cpuinfo | grep "model name" | wc -l`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Memory: `free -m | grep Mem | awk '\{print $2\}'` MB"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Swap: `free -m | grep Swap | awk '\{print $2\}'` MB"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Hard Drive(s): \\n`fdisk -l | grep Disk | grep -v ident`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Power On: \\n`smartctl -a /dev/sda | grep Power_On_Hours`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Disk Firmware Info: \\n`smartctl -a /dev/sda | grep Model && smartctl -a /dev/sda | grep Firmware && \'a0dmesg | grep -i sata | grep 'link up'`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Partition information: \\n`df -h`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 tw_cli info | egrep "^c" | while read controller; do
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0c=($controller); cn=$\{c[0]\}; model=$\{c[1]\};
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0echo "Controller \{$cn\} (\{$model\}):"
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2  \'a0\'a0tw_cli info $cn | egrep "^u" | while read unit; do
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0\'a0\'a0\'a0u=($unit); un=$\{u[0]\}; type=$\{u[1]\}; ustatus=$\{u[2]\}; usize=$\{u[6]\};
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0\'a0\'a0\'a0echo -e "\\tunit $un -- $usize $type (status: $ustatus)";
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
\pard\pardeftab720\sl400\partightenfactor0

\f0\fs29\fsmilli14667 \cf2  \'a0\'a0\'a0\'a0\'a0tw_cli info $cn $un | grep DISK | while read disk; do
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0d=($disk); port=$\{d[5]\}; dstatus=$\{d[2]\}; dsize=$\{d[7]\};
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0echo -e "\\t\\tdisk $port -- $dsize (status: $dstatus)"
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0\'a0\'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667  \'a0\'a0done
\f1\fs24 \

\f0\fs29\fsmilli14667 done
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "`tw_cli /c0/u0 show cache ; tw_cli /c4/u0 show cache ; tw_cli /c0/u1 show cache ; tw_cli /c4/u1 show cache`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "`tw_cli /c0 show firmware ; tw_cli /c4 show firmware`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "IP Addresses: \\n`ip addr | grep "inet " | grep -v "127.0.0.1" | cut -d" " -f 6,11-12`";
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Resolvers"
\f1\fs24 \

\f0\fs29\fsmilli14667 cat /etc/resolv.conf
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Network Speed:"
\f1\fs24 \

\f0\fs29\fsmilli14667 if [ -f /sbin/ethtool ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Eth0`ethtool eth0 | grep Speed`"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Eth1`ethtool eth1 | grep Speed`"
\f1\fs24 \

\f0\fs29\fsmilli14667 else
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "Ethtool is not installed."
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "----------------------------------"
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Checking cPanel licenses......"
\f1\fs24 \

\f0\fs29\fsmilli14667 if [ -f /usr/local/cpanel/cpkeyclt ]
\f1\fs24 \

\f0\fs29\fsmilli14667 then
\f1\fs24 \

\f0\fs29\fsmilli14667 /usr/local/cpanel/cpkeyclt
\f1\fs24 \

\f0\fs29\fsmilli14667 echo -e "cPanel main IP: `cat /var/cpanel/mainip`"
\f1\fs24 \

\f0\fs29\fsmilli14667 else
\f1\fs24 \

\f0\fs29\fsmilli14667 echo "Not a cPanel server."
\f1\fs24 \

\f0\fs29\fsmilli14667 fi
\f1\fs24 \
\pard\pardeftab720\sl280\partightenfactor0
\cf2 \
}