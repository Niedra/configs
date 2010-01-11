-------------------- imports --------------------

--necessary
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import IO (Handle, hPutStrLn) 
import XMonad.Actions.CycleWS

--utilities
import XMonad.Util.Run (spawnPipe)
import XMonad.Actions.NoBorders

--hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.XPropManage
import XMonad.Hooks.FadeInactive

--MO' HOOKS
import Graphics.X11.Xlib.Extras
import Foreign.C.Types (CLong)

--layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
--for gimp
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import Data.Ratio((%))


-------------------- main --------------------

main = do 
	h <- spawnPipe "xmobar ~/.xmobarrc && xmobar ~/.xmobarrc1"
	xmonad $ defaultConfig
		{ workspaces = ["terms", "web", "code", "im", "else"]
		, modMask = mod1Mask
		, borderWidth = 1
		, normalBorderColor = "#1C1C1C"
		, focusedBorderColor = "#FAA73B"
		, terminal = "urxvt"
		, logHook =  logHook' h >> (fadeLogHook)
		, manageHook = manageHook'
		, layoutHook = layoutHook'
		, keys = keys'
		}
-------------------- loghooks --------------------

logHook' ::  Handle -> X ()
logHook' h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "#FBAB3C" ""
		     , ppTitle = shorten 75
		     , ppSep = "<fc=#FBAB3C> | </fc>"
	             , ppHiddenNoWindows = xmobarColor "#737373" ""
                     }
fadeLogHook :: X ()
fadeLogHook = fadeInactiveLogHook fadeAmount
	where fadeAmount = 0.85 
-------------------- layouthooks --------------------

layoutHook' = customLayout
customLayout = onWorkspace "web" (avoidStrutsOn [U] (simpleTabbed)) $ avoidStrutsOn [U] (smartBorders tiled ||| spaced ||| smartBorders (Mirror tiled) ||| noBorders Full ||| gimp)
	where
	 spaced = named "Spacing" $ spacing 2 $ Tall 1 (3/100) (1/2)
	 tiled  = named "Tiled" $ ResizableTall 1 (2/100) (1/2) []
         gimp = withIM (0.11) (Role "toolbox") $ reflectHoriz $ withIM(0.15)(Role "gimp-dock") Full

-------------------- menuhook --------------------

getProp :: Atom -> Window -> X (Maybe [CLong])
getProp a w = withDisplay $ \dpy -> io $ getWindowProperty32 dpy a w

checkAtom name value = ask >>= \w -> liftX $ do
                a <- getAtom name
                val <- getAtom value
                mbr <- getProp a w
                case mbr of
                  Just [r] -> return $ elem (fromIntegral r) [val]
                  _ -> return False 

checkDialog = checkAtom "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DIALOG"
checkMenu = checkAtom "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_MENU"

manageMenus = checkMenu --> doFloat
manageDialogs = checkDialog --> doFloat

-------------------- managehook --------------------

manageHook' :: ManageHook
manageHook' = manageHook defaultConfig <+> manageDocks <+> manageMenus <+> manageDialogs <+> myManageHook

myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [className =? c      --> doFloat | c <- myFloats]
    , [title =? t          --> doFloat | t <- myOtherFloats]
    , [className =? r      --> doIgnore | r <- myIgnores]

    , [className =? im     --> doF (W.shift "irc") | im <- imMessenger]
    , [className =? bw     --> doF (W.shift "web") | bw <- browsers]
    , [className =? e      --> doF (W.shift "else") | e <- elseApps]
    ]
    where
      myFloats = ["Gimp","vlc", "VLC (XVideo output)", "Nitrogen","Thunar","Leafpad", "Eclipse SDK", "adobe-air", "/usr/bin/env/python2.6"]
      myOtherFloats = ["Downloads", "Firefox Preferences", "Save As...", "Send file", "Open", "File Transfers", "amo", "Tasks"]
      myIgnores = ["trayer", "stalonetray"]

      imMessenger = ["Pidgin", "Skype"]
      browsers = ["Shiretoko", "Uzbl", "Chromium"]
      elseApps = ["Mirage"]

-------------------- keybinds --------------------

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

      --launching/killing
      [ ((modMask,               xK_p     ), spawn "dmenu_run -fn \"-*-lime-*-*-*-*-*-*-*-*-*-*-*-*\" -nb \"#1C1C1C\" -nf \"#4d4d4d\" -sb \"#2A2A2A\" -sf \"#D81860\"")
      , ((modMask .|. shiftMask, xK_p	  ), spawn "gmrun")
      , ((modMask .|. shiftMask, xK_Return), spawn "urxvt")
      , ((modMask,               xK_f     ), spawn "firefox") --or spawn "firefox"
      , ((modMask .|. shiftMask, xK_m     ), spawn "urxvt -e ncmpcpp")
      , ((modMask .|. shiftMask, xK_c     ), kill)
      
      --layouts
      , ((modMask,               xK_space ), sendMessage NextLayout)
      , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
      , ((modMask,               xK_b     ), sendMessage ToggleStruts)

      -- refresh
      , ((modMask,               xK_n     ), refresh)
      , ((modMask .|. shiftMask, xK_w     ), withFocused toggleBorder)
 
      -- focus
      , ((modMask,               xK_Tab   ), windows W.focusDown)
      , ((modMask,               xK_j     ), windows W.focusDown)
      , ((modMask,               xK_k     ), windows W.focusUp)
      , ((modMask,               xK_m     ), windows W.focusMaster)
 
      -- swapping
      , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
      , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

      -- my
      , ((controlMask .|. shiftMask, xK_q     ), spawn "~/scripts/DT.sh")
      , ((controlMask .|. shiftMask, xK_x     ), spawn "ncmpcpp toggle")
      , ((modMask,		 xK_e         ), spawn "pcmanfm")
      , ((modMask,               xK_g         ), spawn "gvim")
      , ((modMask,               xK_c         ), spawn "chromium")

      -- increase or decrease number of windows in the master area
      , ((modMask .|. controlMask, xK_h     ), sendMessage (IncMasterN 1))
      , ((modMask .|. controlMask, xK_l     ), sendMessage (IncMasterN (-1)))
        
      -- moving to screens
      , ((modMask .|. shiftMask, xK_Right), prevScreen)
      , ((modMask .|. shiftMask, xK_Left),  nextScreen)
      , ((modMask .|. shiftMask, xK_o),  shiftNextScreen)

      -- resizing
      , ((modMask,               xK_h     ), sendMessage Shrink)
      , ((modMask,               xK_l     ), sendMessage Expand)
      , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
      , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)
     
      -- Push window back into tiling
      , ((modMask ,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
      , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
      , ((modMask               , xK_period), sendMessage (IncMasterN (-1)))

      -- quit, or restart
      , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
      , ((modMask              , xK_q     ), restart "xmonad" True)
      ]
      ++
      -- mod-[1..9] %! Switch to workspace N
      -- mod-shift-[1..9] %! Move client to workspace N
      [((m .|. modMask, k), windows $ f i)
          | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F5]
          , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
