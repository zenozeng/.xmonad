import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Layout.IndependentScreens  

import qualified XMonad.StackSet as W
  
-- 关于GTK的外观，建议使用一个角lxappearance的东西设置一下GTK的主题
-- 切换显示器只要将鼠标移到另一个显示器就好

myKeys = [ 
  ("M1-<Tab>"   , windows W.swapMaster)
  , ("M-<Return>" , spawn "xterm")
  , ("M-<Tab>", windows W.focusDown)
  , ("M-n"  , nextWS) -- go to next workspace
  , ("M-p"  , prevWS) -- go to prev workspace
  , ("M-S-n", shiftToNext) -- move client to next workspace
  , ("M-S-p" , shiftToPrev) -- move client to prev workspace
  , ("M-w", kill)

  -- volume control 
  , ("M-=", spawn "amixer sset Master 10%+")
  , ("M--", spawn "amixer sset Master 10%-")

  -- apps
  , ("M-r", spawn "gmrun"                         ) -- app launcher
  , ("M-g", spawn "google-chrome")
  , ("M-f", spawn "firefox")
  , ("M-e", spawn "emacsclient -c -a '' --no-wait")  
  , ("M-o"        , spawn "nautilus"                      ) -- launch file manager

  , ("M-q"        , spawn "xmonad --restart"              ) -- restart xmonad w/o recompiling
  ]
         

main = xmonad $defaultConfig
       {
         -- basic config
         terminal           = "xterm",
         focusFollowsMouse  = True,
         borderWidth        = 2,
         modMask            = mod4Mask, -- use super
         normalBorderColor  = "#333",
         focusedBorderColor = "#333"
       }
       `additionalKeysP` myKeys
