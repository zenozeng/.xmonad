Config {
--  font = "-*-Fixed-Bold-R-Normal-*-14-*-*-*-*-*-*-*"
  font = "xft:WenQuanYi Micro Hei Mono:size=10:antialias=true"
  , bgColor = "#333"
  , fgColor = "#777"
  , position = Top
  -- , lowerOnStart = True
  , lowerOnStart = False
  , commands = [ 
               Run Battery ["-t", "<left>% <timeleft>", "-L", "20", "-H", "75", "-h",
                              "green", "-n", "yellow", "-l", "red"] 60
               , Run Date "%Y-%m-%d %H:%M" "date" 10
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/volume.sh"] "vol" 1
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/essid.sh"] "essid" 10
               , Run Com "/bin/bash" ["-c", "~/.xmonad/sh/ip.sh"] "ip" 10
               , Run BatteryP ["BAT0"]
                  ["-t", "<left>%",
                   "-L", "10", "-H", "80", "-p", "3",
                   "--", "-O", "<fc=green>On</fc> - ", "-i", "",
                   "-L", "-15", "-H", "-5",
                   "-l", "red", "-m", "blue", "-h", "green"]
                  600
               ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " <fc=#ccc>Vol</fc> %vol% <fc=#ccc>Essid</fc> %essid% %ip% }{ %battery% <fc=#ccc>|</fc> %date% " 
  }
