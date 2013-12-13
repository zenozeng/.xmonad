Config {
  font = "xft:WenQuanYi Micro Hei Mono:size=10:antialias=true"
  , bgColor = "#333"
  , fgColor = "#7c7"
  , position = TopSize L 100 30
  , lowerOnStart = True
  , commands = [ 
               Run Battery ["-t", "<left>% <timeleft>", "-L", "20", "-H", "75", "-h",
                              "green", "-n", "yellow", "-l", "red"] 60
               , Run Date "%Y-%m-%d %H:%M:%S" "date" 10
               , Run BatteryP ["BAT0"]
                  ["-t", "<left>%",
                   "-L", "10", "-H", "80", "-p", "3",
                   "--", "-O", "<fc=green>On</fc> - ", "-i", "",
                   "-L", "-15", "-H", "-5",
                   "-l", "red", "-m", "blue", "-h", "green"]
                  600
               , Run XMonadLog
               , Run Com "/home/zeno/.xmonad/sh/volume.sh" [] "vol" 100
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/essid.sh"] "essid" 10
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/ip.sh"] "ip" 10
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/uptime.sh"] "uptime" 100
               ]
  , sepChar = "%"
  , alignSep = "||"
  , template = "%XMonadLog% || <fc=#999>Vol</fc> %vol%  <fc=#999>Wlan</fc> %essid% %ip%  <fc=#999>Battery</fc> %battery%  <fc=#999>Date</fc> %date% " 
  }
