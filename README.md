# pineroot

* Buildroot image for [PinePhone](https://wiki.pine64.org/index.php/PinePhone).

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
