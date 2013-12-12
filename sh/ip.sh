#!/bin/bash
/sbin/ifconfig wlan0 | grep -o 'inet addr[^ ]*' | grep -o '[0-9.]*'
