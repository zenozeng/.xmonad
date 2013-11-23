import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Layout.IndependentScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.DynamicWorkspaces
import Control.Monad (liftM2)

import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger  
  
import qualified XMonad.StackSet as W
import qualified Data.Map as M


-- 关于GTK的外观，建议使用一个角lxappearance的东西设置一下GTK的主题
-- 切换显示器只要将鼠标移到另一个显示器就好

myKeys = [ 
  ("M1-<Tab>"   , windows W.swapMaster)
  , ("M-<Return>" , spawn "gnome-terminal")
  , ("M-<Tab>", windows W.focusDown)
  , ("M-n"  , nextWS) -- go to next workspace
  , ("M-p"  , prevWS) -- go to prev workspace
  , ("M-S-n", shiftToNext) -- move client to next workspace
  , ("M-S-p" , shiftToPrev) -- move client to prev workspace
  , ("M-k", kill)

  , ("M-q"        , spawn "xmonad --restart") -- restart xmonad w/o recompiling

    -- sleep
  , ("<XF86Sleep>", spawn "sudo pm-suspend-hybrid && /usr/lib/kde4/libexec/kscreenlocker --forcelock")
    
    -- lock
  , ("<XF86ScreenSaver>", spawn "/usr/lib/kde4/libexec/kscreenlocker --forcelock")

    -- volume control 
  , ("M-=", spawn "amixer sset Master 10%+")
  , ("M--", spawn "amixer sset Master 10%-")
  , ("<XF86AudioMute>",	spawn "amixer -q set Master toggle")
  , ("<XF86AudioLowerVolume>",	spawn "amixer -q set Master 3%-")
  , ("<XF86AudioRaiseVolume>",	spawn "amixer -q set Master 3%+")

    -- print srceen
  , ("<Print>", spawn "scrot PrtSc.png")

    -- workspace
  , ("M-e", do
        windows $ W.greedyView "emacs"
        spawn "pgrep emacs || emacsclient -c -a '' --no-wait")
  , ("M-f", do
        windows $ W.greedyView "ff")
  , ("M-v", do
        windows $ W.greedyView "vbox"
        spawn "pgrep VirtualBox || virtualbox")
  , ("M-d", do
        windows $ W.greedyView "firefoxDevtools")
  , ("M-g", do
        windows $ W.greedyView "gimp"
        spawn "pgrep gimp || gimp")
  , ("M-c", do
        windows $ W.greedyView "chrome"
        spawn "pgrep chrome || google-chrome")
  , ("M-o", do
        windows $ W.greedyView "files"
        spawn "pgrep dolphin || dolphin")
  , ("M-t",  windows $ W.greedyView "etc")
  , ("M-s", do
        windows $ W.greedyView "shell"
        spawn "pgrep gnome-terminal || gnome-terminal")

    -- apps
  , ("M-r", spawn "gmrun") -- app launcher
  , ("M-l d", spawn "dolphin")
  , ("M-l f", spawn "firefox")
  , ("M-l c", spawn "google-chrome")    
  , ("M-l s", spawn "gksu synaptic")
  , ("M-l e", spawn "emacsclient -c -a '' --no-wait")
  , ("M-l b", spawn "calibre") -- books  
  ]
         

myStartupHook = do
  spawn "sh -c /home/zeno/sh/init.sh"
  spawn "gnome-terminal -x sudo /home/zeno/sh/root-server.sh"

-- to get the prop of a program, run xprop, eg. xprop | grep WM_CLASS  

myManageHook = composeAll
    [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , (className =? "Firefox" <&&> resource=? "Download") --> doFloat 
    , (className =? "Firefox" <&&> resource =? "DTA") --> doFloat 
--    , (role =? "toolbox") --> doShift "firefoxDevtools"
    , (className =? "VirtualBox") --> doShift "vbox"
--      doF (W.shift "ff") -- Firefox Devtools
--      doShift "firefoxDevtools" -- Firefox Devtools
--    , (className =? "Iceweasel") --> doF (W.shift "ff")
--    , (className =? "Emacs") --> doF (W.shift "emacs")
--    , (className =? "Iceweasel") --> viewShift "ff"
--    , (className =? "Dolphin") --> doShift "files"
--    , (className =? "Google-chrome") --> doShift "chrome"
    ]
  where role = stringProperty "WM_WINDOW_ROLE"
--        viewShift = doF . liftM2 (.) W.greedyView W.shift


myWorkspaces = [
  "emacs",
  "ff",
  "chrome",
  "files",
  "shell",
  "gimp",
  "webdev",
  "firefoxDevtools",
  "etc",
  "vbox"
  ]

        
myLayout = mouseResize $ windowArrange $ layoutHook defaultConfig

main = do
  xmonad $defaultConfig
       {
         -- basic config
         terminal           = "gnome-terminal",
         focusFollowsMouse  = True,
         workspaces         = myWorkspaces,
         layoutHook         = myLayout,
         startupHook        = myStartupHook,
         borderWidth        = 2,
         modMask            = mod4Mask, -- use super
         manageHook         =  myManageHook <+> manageSpawn <+> manageHook defaultConfig,
         normalBorderColor  = "#333",
         focusedBorderColor = "#333"
       }
       `additionalKeysP` myKeys
