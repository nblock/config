#!/bin/bash
if [ `rfkill list 1 |grep "Soft blocked: yes" |wc -l` -eq 0 ]; then
  sudo rfkill block 1
else
  sudo rfkill unblock 1
fi
