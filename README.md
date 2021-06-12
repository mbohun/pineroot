# pineroot

Buildroot environment for [PinePhone](https://wiki.pine64.org/index.php/PinePhone)

![buildroot process](https://github.com/e59e4835/pineroot/blob/master/img/buildroot-process.png)


## Build

```
git clone https://github.com/e59e4835/pineroot.git
cd pineroot/buildroot-2021.02.2/
make pinephone_defconfig
make
```

## Graphic test

```
glmark2-es2-drm
```

## Wifi configuration

iwd based wifi

```
iwctl --passphrase [psk] station wlan0 connect [ssid]
```
## Modem start/stop

### request powerup
```
echo 1 > /sys/class/modem-power/modem-power/device/powered
```
### request powerdown
```
echo 0 > /sys/class/modem-power/modem-power/device/powered
```
### read power status (changes only after power state transition is complete)
```
cat /sys/class/modem-power/modem-power/device/powered
```

# Mobile data activation 

```
# Power modem up (and wait ~20 seconds)
echo 1 > /sys/class/modem-power/modem-power/device/powered
# Check link layer protocol format
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wda-get-data-format
# Interface down
ip link set dev wwan0 down
# If interface suports raw_ip, change it
cat /sys/class/net/wwan0/qmi/raw_ip
echo Y > /sys/class/net/wwan0/qmi/raw_ip
# Interface up
ip link set dev wwan0 up
# Activate connection with 'internet' APN
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4,apn=internet" --client-no-release-cid
# Get IP with dhcp
udhcpc -q -f -n -i wwan0
```

## Weston

```
/usr/bin/weston -i0 --tty=3 &
weston-flower
```

## literm

```
literm -platform wayland-egl -fullscreen -mobile
```

## qml-launcher

```
qml-launcher -platform wayland-egl
```
