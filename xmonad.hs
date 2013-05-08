import XMonad
import XMonad.Actions.CycleWS    
import XMonad.Actions.CycleWindows
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Layout.NoBorders     -- no borders on solo clients

  
myKeys = [ 
  ("M1-<Tab>"   , cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab ) -- classic alt-tab behaviour
  , ("M-<Return>" , spawn "xterm")
  , ("M-<Tab>"    , toggleWS                              ) -- toggle last workspace (super-tab)
  , ("M-n"  , nextWS                                ) -- go to next workspace
  , ("M-p"  , prevWS                                ) -- go to prev workspace
  , ("M-S-n", shiftToNext                           ) -- move client to next workspace
  , ("M-S-p" , shiftToPrev                           ) -- move client to prev workspace
  , ("M-r"        , spawn "gmrun"                         ) -- app launcher
  , ("M-f", spawn "firefox")
  , ("M-w", kill) -- launch browser
  , ("M-e"        , spawn "nautilus"                      ) -- launch file manager
  , ("M-q"        , spawn "xmonad --restart"              ) -- restart xmonad w/o recompiling
  ]
         

main = xmonad $defaultConfig
       {
         -- basic config
         terminal           = "xterm",
         focusFollowsMouse  = True,
         borderWidth        = 2,
         modMask            = mod4Mask, -- use super
         normalBorderColor  = "#111111",
         focusedBorderColor = "#111111"
       }
       `additionalKeysP` myKeys
