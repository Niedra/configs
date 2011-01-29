xsetroot -cursor_name left_ptr

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

case $1 in
awesome)
        ck-launch-session&
        parcellite &
        dropboxd &
        setxkbmap lv -variant tilde
        exec awesome
        ;;
openbox)
	    openbox-session
	    ;;
kde)
        startkde
        ;;
gnome)
        ck-launch-session&
        gnome-session
        ;;
*)
        export DE=gnome &
#	    glipper-old &
#        trayer --edge top --align right --heighttype pixel --height 15 --SetDockType false --widthtype pixel --width 350 --margin 207 --tint 0x1c1c1c --transparent true --alpha 0 &
        setxkbmap lv -variant tilde &
        dropboxd &
        xrandr --screen 0 -s 1680x1050 &
    	exec ck-launch-session dbus-launch awesome 
	;;
esac
