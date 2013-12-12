#!/bin/bash
amixer sget Master,0 | grep -o '[0-9,]\+%' | head -n1
