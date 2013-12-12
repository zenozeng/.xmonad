import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Layout.IndependentScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.DynamicWorkspaces
import Control.Monad (liftM2)
import XMonad.Layout.WindowArranger
import XMonad.Layout.BorderResize
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as FlexR

-- Define Functions
lock = spawn "/usr/lib/kde4/libexec/kscreenlocker --forcelock"
sleep = spawn "sudo pm-suspend-hybrid && /usr/lib/kde4/libexec/kscreenlocker --forcelock"


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

  , ("<XF86Sleep>", sleep)
  , ("<XF86ScreenSaver>", lock)
  , ("M-S-l", lock)

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
  , ("M-g", do
        windows $ W.greedyView "gimp"
        spawn "pgrep gimp || gimp")
  , ("M-c", do
        windows $ W.greedyView "chrome"
        spawn "pgrep chrome || google-chrome")
  , ("M-t",  windows $ W.greedyView "etc")
  , ("M-s", do
        windows $ W.greedyView "shell"
        spawn "pgrep gnome-terminal || gnome-terminal")
  ]
         

myStartupHook = do
  spawn "sh -c /home/zeno/sh/init.sh"
  spawn "pgrep redshift || redshift -l 30.3:120.2 -t 6400:5400 &"
  spawn "pgrep xcompmgr || xcompmgr"
  spawn "pgrep synapse || synapse -s" -- I bind this on M-f

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
  "chrome",
  "shell",
  "gimp",
  "etc"
  ]

main = do
  xmonad $defaultConfig
       {
         terminal           = "gnome-terminal"
         , focusFollowsMouse  = True
         , workspaces         = myWorkspaces
         , startupHook        = myStartupHook
         , borderWidth        = 0
         , modMask            = mod4Mask -- use super
         , manageHook         =  myManageHook <+> manageSpawn <+> manageHook defaultConfig
         , normalBorderColor  = "#333"
         , focusedBorderColor = "#555"
       }
       `additionalKeysP` myKeys
