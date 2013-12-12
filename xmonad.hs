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
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Hooks.EwmhDesktops

-- Define Functions
lock = spawn "/usr/lib/kde4/libexec/kscreenlocker --forcelock"
sleep = spawn "sudo pm-suspend-hybrid && /usr/lib/kde4/libexec/kscreenlocker --forcelock"
printScreen interactive = let
  cmd = " '%Y-%m-%dT%H:%m:%S_$wx$h.png' -e 'mv $f ~/shots/'"
  a = "sleep 0.2; scrot -s"++cmd
  b = "scrot"++cmd    
  in if interactive
     then spawn a
     else spawn b

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
  , ("M-l", lock)
  , ("M-=", spawn "amixer sset Master 10%+")
  , ("M--", spawn "amixer sset Master 10%-")
  , ("<XF86AudioMute>",	spawn "amixer -q set Master toggle")
  , ("<XF86AudioLowerVolume>",	spawn "amixer -q set Master 3%-")
  , ("<XF86AudioRaiseVolume>",	spawn "amixer -q set Master 3%+")
  , ("<Print>", printScreen False)
  , ("S-<Print>", printScreen True)
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
  , ("M-1", windows $ W.greedyView "untitled-1")
  , ("M-2", windows $ W.greedyView "untitled-2")
  , ("M-3", windows $ W.greedyView "untitled-3")
  , ("M-4", windows $ W.greedyView "untitled-4")
  ]
         

myStartupHook = do
  spawn "sh -c /home/zeno/sh/init.sh"
  spawn "pgrep redshift || redshift -l 30.3:120.2 -t 6400:5400 &"
  spawn "pgrep xcompmgr || xcompmgr"
  spawn "pgrep synapse || synapse -s"

myManageHook = composeAll
    [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , (className =? "Firefox" <&&> resource=? "Download") --> doFloat 
    , (className =? "Firefox" <&&> resource =? "DTA") --> doFloat 
    , (className =? "VirtualBox") --> doShift "vbox"
    ]
  where role = stringProperty "WM_WINDOW_ROLE"

myWorkspaces = [
  "emacs"
  , "chrome"
  , "shell"
  , "gimp"
  , "untitled-1"
  , "untitled-2"
  , "untitled-3"
  , "untitled-4"
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
         , handleEventHook    = fullscreenEventHook
         , manageHook         =  myManageHook <+> manageSpawn <+> manageHook defaultConfig
         , normalBorderColor  = "#333"
         , focusedBorderColor = "#555"
       }
       `additionalKeysP` myKeys
