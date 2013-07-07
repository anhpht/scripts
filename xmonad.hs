-- Imports {{{
import XMonad
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
-- Hooks
import XMonad.Operations
import System.IO
import System.Exit
import XMonad.Util.Run
import XMonad.Actions.CycleWS

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.Reflect (reflectHoriz)
import XMonad.Layout.IM
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid

import Data.Ratio ((%))
import qualified XMonad.StackSet as W
import qualified Data.Map as M
--}}}

-- Config {{{
-- Define Terminal
myTerminal      = "/usr/bin/urxvtc"
-- Define modMask
modMask' :: KeyMask
modMask' = mod4Mask
-- Define workspaces
myWorkspaces    = ["1:main","2:web","3:chat","4:docs","5:others"]
-- Dzen/Conky
myXmonadBar = "dzen2 -x '1440' -y '0' -h '24' -w '640' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myStatusBar = "conky -c /home/fta/.xmonad/.conky_dzen | dzen2 -x '2080' -w '1000' -h '24' -ta 'r' -fg '#FFFFFF' -y '0'"
myBitmapsDir = "/home/fta/.xmonad/dzen2"
--}}}
-- Main {{{
main = do
    dzenLeftBar <- spawnPipe myXmonadBar
--    dzenRightBar <- spawnPipe myStatusBar
    xmonad $ defaultConfig
      {
        terminal            = myTerminal,
        workspaces          = myWorkspaces,
        keys                = keys',
        modMask             = modMask',
        layoutHook          = layoutHook',
        manageHook          = manageHook',
        logHook             = myLogHook dzenLeftBar >> fadeInactiveLogHook 0xdddddddd,
        normalBorderColor   = colorNormalBorder,
        focusedBorderColor  = colorFocusedBorder,
        borderWidth         = 2
      }
--}}}


-- Hooks {{{
-- ManageHook {{{
manageHook' :: ManageHook
manageHook' = (composeAll . concat $
    [ [resource     =? r            --> doIgnore            |   r   <- myIgnores] -- ignore desktop
    , [className    =? c            --> doShift  "1:main"   |   c   <- myDev    ] -- move dev to main
    , [className    =? c            --> doShift  "2:web"    |   c   <- myWebs   ] -- move webs to web
    , [className    =? c            --> doShift  "3:chat"   |   c   <- myChat   ] -- move chat to chat
    , [className    =? c            --> doShift  "4:docs"   |   c   <- myDocs   ] -- move documents to documents
    , [className    =? c            --> doShift  "5:others" |   c   <- myOthers ] -- move others to others
    , [className    =? c            --> doCenterFloat       |   c   <- myFloats ] -- float my floats
    , [name         =? n            --> doCenterFloat       |   n   <- myNames  ] -- float my names
    , [isFullscreen                 --> myDoFullFloat                           ]
    ])

    where
        role      = stringProperty "WM_WINDOW_ROLE"
        name      = stringProperty "WM_NAME"
        -- classnames
        myFloats  = ["Xmessage", "XFontSel", "Wicd Network Manager", "Emacs", "Gvim", "Gedit", "Komodo Edit", "meld", "thunar", "feh"]
        myWebs    = ["Firefox", "Google-chrome", "Chromium", "Chromium-browser"]
        myOthers  = ["Vlc", "Gimp", "VirtualBox", "realvnc-viewer"]
        myChat    = ["Pidgin", "Buddy List", "Skype", "Thunderbird"]
        myDev     = ["Konsole", "gnome-terminal", "URxvt"]
        myDocs    = ["Evince", "Xchm", "libreoffice-startcenter", "libreoffice-writer", "libreoffice-calc", "libreoffice-impress", "libreoffice-draw", "Xpdf"]

        -- resources
        myIgnores = ["desktop", "desktop_window", "notify-osd", "stalonetray", "trayer"]

        -- names
        myNames   = ["bashrun"]

-- a trick for fullscreen but stil allow focusing of other WSs
myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat
-- }}}
layoutHook'  =  onWorkspaces ["1:main","3:chat", "5:others"] customLayout1 $
                customLayout2

--Bar
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
      , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
      , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      , ppLayout            =   dzenColor "#ebac54" "#1B1D1E" .
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    "Simple Float"              ->      "~"
                                    _                           ->      x
                                )
      , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

-- Layout
--customLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full ||| simpleFloat
--customLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full
--  where
--    tiled   = ResizableTall 1 (2/100) (5/8) []

customLayout1 = avoidStruts $ tiled ||| Full
  where
    tiled   = ResizableTall 1 (2/100) (5/8) []

customLayout2 = avoidStruts $ Full ||| tiled ||| Mirror tiled
  where
    tiled   = ResizableTall 1 (2/100) (5/8) []

-- imLayout    = avoidStruts $ withIM (1%5) (And (ClassName "Pidgin") (Role "buddy_list")) Grid
--}}}
-- Theme {{{
-- Color names are easier to remember:
colorOrange         = "#FD971F"
colorDarkGray       = "#1B1D1E"
colorPink           = "#F92672"
colorGreen          = "#A6E22E"
colorBlue           = "#66D9EF"
colorYellow         = "#E6DB74"
colorWhite          = "#CCCCC6"

colorNormalBorder   = "#CCCCC6"
colorFocusedBorder  = "#fd971f"


barFont  = "terminus"
barXFont = "inconsolata:size=12"
xftFont = "xft: inconsolata-14"
--}}}

-- Prompt Config {{{
mXPConfig :: XPConfig
mXPConfig =
    defaultXPConfig { font                  = barFont
                    , bgColor               = colorDarkGray
                    , fgColor               = colorGreen
                    , bgHLight              = colorGreen
                    , fgHLight              = colorDarkGray
                    , promptBorderWidth     = 0
                    , height                = 14
                    , historyFilter         = deleteConsecutive
                    }

-- Run or Raise Menu
largeXPConfig :: XPConfig
largeXPConfig = mXPConfig
                { font = xftFont
                , height = 22
                }
-- }}}
-- Key mapping {{{
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask,                    xK_r        ), runOrRaisePrompt largeXPConfig)
    , ((modMask .|. shiftMask,      xK_Return   ), spawn $ XMonad.terminal conf)
    , ((modMask,                    xK_F2       ), spawn "/usr/bin/gmrun")
    , ((modMask .|. shiftMask,      xK_c        ), kill)
    , ((modMask .|. shiftMask,      xK_l        ), spawn "/usr/bin/xscreensaver-command -lock")
    -- Programs
    , ((0,                          xK_Print    ), spawn "/usr/bin/scrot -e 'mv $f ~/screenshots/'")
    , ((modMask,                    xK_f        ), spawn "/usr/bin/chromium")
    , ((modMask,                    xK_o        ), spawn "EDITOR=vim /usr/bin/urxvtc -e /usr/bin/ranger /mnt/data")
    , ((modMask,                    xK_u        ), spawn "/usr/bin/urxvtc")
    , ((modMask,                    xK_t        ), spawn "/usr/bin/thunar /mnt/data")
    , ((modMask,                    xK_v        ), spawn "/usr/bin/virtualbox")
    , ((modMask,                    xK_p        ), spawn "/usr/bin/urxvtc -e /usr/bin/ncmpc")
    , ((modMask,                    xK_s        ), spawn "/usr/bin/subl")
    , ((modMask,                    xK_w        ), spawn "/usr/bin/realvnc-viewer")
    , ((modMask,                    xK_m        ), spawn "/usr/bin/gnome-alsamixer")

    -- layouts
    , ((modMask,                    xK_space    ), sendMessage NextLayout)
    , ((modMask .|. shiftMask,      xK_space    ), setLayout $ XMonad.layoutHook conf)          -- reset layout on current desktop to default
    , ((modMask,                    xK_b        ), sendMessage ToggleStruts)
    , ((modMask,                    xK_n        ), refresh)
    , ((modMask,                    xK_Tab      ), windows W.focusDown)                         -- move focus to next window
    , ((modMask,                    xK_j        ), windows W.focusDown)
    , ((modMask,                    xK_k        ), windows W.focusUp  )
    , ((modMask .|. shiftMask,      xK_j        ), windows W.swapDown)                          -- swap the focused window with the next window
    , ((modMask .|. shiftMask,      xK_k        ), windows W.swapUp)                            -- swap the focused window with the previous window
    , ((modMask,                    xK_Return   ), windows W.swapMaster)
--    , ((modMask,                    xK_t        ), withFocused $ windows . W.sink)              -- Push window back into tiling
    , ((modMask,                    xK_h        ), sendMessage Shrink)                          -- %! Shrink a master area
    , ((modMask,                    xK_l        ), sendMessage Expand)                          -- %! Expand a master area
    , ((modMask,                    xK_comma    ), sendMessage (IncMasterN 1))
    , ((modMask,                    xK_period   ), sendMessage (IncMasterN (-1)))

    -- workspaces
    , ((modMask .|. controlMask,   xK_Right     ), nextWS)
    , ((modMask .|. shiftMask,     xK_Right     ), shiftToNext)
    , ((modMask .|. controlMask,   xK_Left      ), prevWS)
    , ((modMask .|. shiftMask,     xK_Left      ), shiftToPrev)

    -- quit, or restart
    , ((modMask .|. shiftMask,      xK_q        ), io (exitWith ExitSuccess))
    , ((modMask,                    xK_q        ), spawn "killall conky dzen2 && /usr/bin/xmonad --recompile && /usr/bin/xmonad --restart")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--  ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--}}}
