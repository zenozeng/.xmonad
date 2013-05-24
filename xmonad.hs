import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Layout.IndependentScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.DynamicWorkspaces
import Control.Monad (liftM2)
  
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
  , ("M-w", kill)

    -- volume control 
  , ("M-=", spawn "amixer sset Master 10%+")
  , ("M--", spawn "amixer sset Master 10%-")

    -- print srceen
  , ("M-l p", spawn "sleep 0.2; scrot -s")

    -- workspace
  , ("M-e",  windows $ W.greedyView "emacs")
  , ("M-f",  windows $ W.greedyView "ff")
  , ("M-g",  windows $ W.greedyView "chrome")
  , ("M-o",  windows $ W.greedyView "files")
  , ("M-t",  windows $ W.greedyView "etc")
  , ("M-s",  windows $ W.greedyView "shell")

    -- apps
  , ("M-r", spawn "gmrun") -- app launcher
--  , ("M-g", spawn "google-chrome")
--  , ("M-f", spawn "firefox")
--  , ("M-e", spawn "emacsclient -c -a '' --no-wait")  
--  , ("M-o"        , spawn "dolphin"                      ) -- launch file manager
  , ("M-l s", spawn "gksu synaptic")
  , ("M-q"        , spawn "xmonad --restart"              ) -- restart xmonad w/o recompiling
  , ("<XF86AudioMute>",	spawn "amixer -q set Master toggle")
  , ("<XF86AudioLowerVolume>",	spawn "amixer -q set Master 3%-")
  , ("<XF86AudioRaiseVolume>",	spawn "amixer -q set Master 3%+")    
  ]
         

myStartupHook = do
  spawn "bash /home/zeno/sh/startup.sh"
  windows $ W.greedyView "emacs"
  spawn "pstree | grep emacs || emacsclient -c -a '' --no-wait"
  spawn "pstree | grep iceweasel || firefox"
  spawn "pstree | grep chrome || google-chrome" 
  spawn "pstree | grep dolphin || dolphin"
  windows $ W.greedyView "shell"
  spawn "pstree | grep gnome-terminal || gnome-terminal"

myManageHook = composeAll
    [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , (className =? "Iceweasel") --> doShift "ff"
--    , (className =? "Iceweasel") --> doF (W.shift "ff")
--    , (className =? "Emacs") --> doF (W.shift "emacs")
--    , (className =? "Iceweasel") --> viewShift "ff"
    , (className =? "Dolphin") --> doShift "files"
    , (className =? "Google-chrome") --> doShift "chrome"
    ]
  where role = stringProperty "WM_WINDOW_ROLE"
--        viewShift = doF . liftM2 (.) W.greedyView W.shift


myWorkspaces = [
  "emacs",
  "ff",
  "chrome",
  "files",
  "shell",
  "etc"
  ]

        
main = do
  xmonad $defaultConfig
       {
         -- basic config
         terminal           = "gnome-terminal",
         focusFollowsMouse  = True,
         workspaces         = myWorkspaces,
         startupHook        = myStartupHook,
         borderWidth        = 2,
         modMask            = mod4Mask, -- use super
         manageHook         =  myManageHook <+> manageSpawn <+> manageHook defaultConfig,
         normalBorderColor  = "#333",
         focusedBorderColor = "#333"
       }
       `additionalKeysP` myKeys
