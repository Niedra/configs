#DEFAULT_SESSION=openbox-session
xsetroot -cursor_name left_ptr

case $1 in
xmonad)
        ck-launch-session&
	nitrogen --restore&
	parcellite &
        trayer --edge top --align right --heighttype pixel --height 15 --SetDockType false --widthtype pixel --width 350 --margin 207 --tint 0x1c1c1c --transparent true --alpha 0 &
	setxkbmap lv -variant tilde &
        dropboxd &
        claws-mail&
        xcompmgr &
	exec xmonad
	;;
awesome)
        ck-launch-session&
        parcellite &
        dropboxd &
        claws-mail &
        setxkbmap lv -variant tilde
        exec awesome
        ;;
openbox)
	openbox-session
	;;
gnome)
        ck-launch-session&
        gnome-session
        ;;
*)
        ck-launch-session&
#	nitrogen --restore&
	parcellite &
#        trayer --edge top --align right --heighttype pixel --height 15 --SetDockType false --widthtype pixel --width 350 --margin 207 --tint 0x1c1c1c --transparent true --alpha 0 &
	setxkbmap lv -variant tilde &
        dropboxd &
        claws-mail &
        xscreensaver -no-splash &
 #       xcompmgr &
	exec awesome
	;;
esac
