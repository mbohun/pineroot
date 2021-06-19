#
# Manual LTE connect
#

MODEM_POWER=$(cat /sys/class/modem-power/modem-power/device/powered)

if [ $MODEM_POWER -eq "0" ]
then
echo 1 > /sys/class/modem-power/modem-power/device/powered
sleep 20
fi


# check link layer protocol 
# qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wda-get-data-format

#
# Interface down & apply raw_ip
#
ip link set dev wwan0 down
cat /sys/class/net/wwan0/qmi/raw_ip
echo Y > /sys/class/net/wwan0/qmi/raw_ip
#
# Interface up, connect and get IP with dhcp
#
ip link set dev wwan0 up
sleep 2
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4,apn=internet" --client-no-release-cid
sleep 2
udhcpc -q -f -n -i wwan0

#
# iptables
#

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X

WANINTERFACE=wwan0
USBINTERFACE=usb0

iptables -A FORWARD -i $USBINTERFACE -o $WANINTERFACE -j ACCEPT
iptables -A FORWARD -i $WANINTERFACE -o $USBINTERFACE -m state --state ESTABLISHED,RELATED \
         -j ACCEPT
iptables -t nat -A POSTROUTING -o $WANINTERFACE -j MASQUERADE

