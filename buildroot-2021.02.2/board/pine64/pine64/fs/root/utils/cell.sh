#!/bin/sh
#
# Small utility to read Cellular environment through QMI
#

#
# Voltage round function
#
round()
{
echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};


#
# Init values to /tmp/env file
#
VOLTAGE=$(cat /sys/class/power_supply/axp20x-battery/voltage_now)
VOLTAGE=$(round $VOLTAGE/1000000 2)
echo $VOLTAGE,-,-,-,-,-,-,-,-,- > /tmp/env

#
# Wait until modem is powered up
#
MODEM_POWER=$(cat /sys/class/modem-power/modem-power/device/powered)
while [ $MODEM_POWER -eq "0" ]
do
sleep 1
MODEM_POWER=$(cat /sys/class/modem-power/modem-power/device/powered)
done



while [ 1 ]
do

#
# Check that modem is on
#
MODEM_POWER=$(cat /sys/class/modem-power/modem-power/device/powered)
if [ $MODEM_POWER -eq "0" ]
then
exit
fi


#
# Battery voltage
#
VOLTAGE=$(cat /sys/class/power_supply/axp20x-battery/voltage_now)
VOLTAGE=$(round $VOLTAGE/1000000 2)

#
# Cell location info
#
qmicli -p -d /dev/cdc-wdm0 --nas-get-cell-location-info > /tmp/nas-get-cell-location-info
INFOFILE=/tmp/nas-get-cell-location-info
PLMN=$(grep PLMN $INFOFILE|cut -d"'" -f2)
TRACKING_AREA_CODE=$(grep "Tracking Area Code" $INFOFILE|cut -d"'" -f2)
GLOBAL_CELL_ID=$(grep "Global Cell ID" $INFOFILE|cut -d"'" -f2)
SERVING_CELL_ID=$(grep "Serving Cell ID" $INFOFILE|cut -d"'" -f2)
EUTRA_ABSOLUTE_RF_CHANNEL_NUMBER=$(grep "EUTRA Absolute RF Channel Number" $INFOFILE|cut -d"(" -f2|cut -d"(" -f2|cut -d")" -f1|head -1)
sleep 5

#
# Signal info
#
qmicli -p -d /dev/cdc-wdm0 --nas-get-signal-info > /tmp/nas-get-signal-info
INFOFILE=/tmp/nas-get-signal-info
RSSI=$(grep "RSSI" $INFOFILE|cut -d"'" -f2)
RSRQ=$(grep "RSRQ" $INFOFILE|cut -d"'" -f2)
RSRP=$(grep "RSRP" $INFOFILE|cut -d"'" -f2)
SNR=$(grep "SNR" $INFOFILE|cut -d"'" -f2)
echo $VOLTAGE,$PLMN,$TRACKING_AREA_CODE,$GLOBAL_CELL_ID,$SERVING_CELL_ID,$EUTRA_ABSOLUTE_RF_CHANNEL_NUMBER,$RSSI,$RSRQ,$RSRP,$SNR > /tmp/env
# echo $VOLTAGE,$PLMN,$TRACKING_AREA_CODE,$GLOBAL_CELL_ID,$SERVING_CELL_ID,$EUTRA_ABSOLUTE_RF_CHANNEL_NUMBER,$RSSI,$RSRQ,$RSRP,$SNR
sleep 5

done
