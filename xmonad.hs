import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
  
myKeys = [ 
  ("M1-<Tab>"   , cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab ) -- classic alt-tab behaviour
  , ("M-<Return>" , spawn "xterm")
  , ("M-<Tab>"    , toggleWS                              ) -- toggle last workspace (super-tab)
  , ("M-n"  , nextWS                                ) -- go to next workspace
  , ("M-p"  , prevWS                                ) -- go to prev workspace
  , ("M-S-n", shiftToNext                           ) -- move client to next workspace
  , ("M-S-p" , shiftToPrev                           ) -- move client to prev workspace
  , ("M-w", kill)

  -- volume control 
  , ("M-=", spawn "amixer sset Master 10%+")
  , ("M--", spawn "amixer sset Master 10%-")

  -- apps
  , ("M-r"        , spawn "gmrun"                         ) -- app launcher
  , ("M-g", spawn "google-chrome")
  , ("M-f", spawn "firefox")
  , ("M-e", spawn "emacsclient -c -a '' --no-wait")  
  --  , ("M-e"        , spawn "nautilus"                      ) -- launch file manager

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
