#!/bin/bash
/sbin/iwconfig wlan0 | grep -o 'ESSID:[^ ]*' | grep -o '[^:"]*' | tail -n1

