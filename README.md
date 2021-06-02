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
