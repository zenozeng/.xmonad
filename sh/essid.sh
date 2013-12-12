#!/bin/bash
/sbin/iwconfig wlan0 | grep -o 'ESSID:[^ ]*' | sed 's/[(ESSID:)"]//g'
