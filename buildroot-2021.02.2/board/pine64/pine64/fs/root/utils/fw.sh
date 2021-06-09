echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

WANINTERFACE=wlan0
USBINTERFACE=usb0

iptables -A FORWARD -i $USBINTERFACE -o $WANINTERFACE -j ACCEPT
iptables -A FORWARD -i $WANINTERFACE -o $USBINTERFACE -m state --state ESTABLISHED,RELATED \
         -j ACCEPT
iptables -t nat -A POSTROUTING -o $WANINTERFACE -j MASQUERADE
