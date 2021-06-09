#
# Manual LTE power on & connect
#
echo 1 > /sys/class/modem-power/modem-power/device/powered
sleep 20
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
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4,apn=internet" --client-no-release-cid
udhcpc -q -f -n -i wwan0
