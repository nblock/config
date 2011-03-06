#!/bin/bash

if [ `synclient -l | grep TouchpadOff | cut -b 31-32` -ne 0 ]; then
  synclient TouchpadOff=0
  xinput set-int-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 8 0
else
  synclient TouchpadOff=1
  xinput set-int-prop "TPPS/2 IBM TrackPoint" "Device Enabled" 8 1
fi
