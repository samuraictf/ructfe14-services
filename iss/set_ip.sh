#!/bin/sh

trap 'echo -e "\nYou can rerun this script by /root/set_ip.sh"; exit' INT

echo RuCTFe 2014
echo

if ! ifconfig -I /dev/ip0 2>/dev/null >/dev/null; then
 echo "Warning: you don't have an /dev/ip0 interface. This can cause troubles."
 echo
fi

read -p "Lets generate net config. Enter your team number: " TEAM

echo "ifconfig -I /dev/ip0 -n 255.255.255.0 -h 10.$((60 + TEAM / 256)).$((TEAM % 256)).4" > /etc/rc.net
echo "add_route -g 10.$((60 + TEAM / 256)).$((TEAM % 256)).1" >> /etc/rc.net
echo "daemonize nonamed -L" >> /etc/rc.net
echo "daemonize sh /home/iss/iss.sh" >> /etc/rc.net

echo "Here is your new /etc/rc.net:"
cat /etc/rc.net
echo

echo
echo "Network configuration is over."
echo "If the network works unstable, disconnect and connect virtual network adapter in VitrualBox and wait for a few minutes."
echo

echo "Press enter to reboot, press Ctrl-C to abort"
read enter
mv /root/set_ip.sh /root/set_ip.sh.old && shutdown -r now
