xsetroot -cursor_name left_ptr

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

case $1 in
awesome)
        setxkbmap lv -variant tilde &
        dropboxd &

        pidof mpdscribble >& /dev/null
        if [ $? -ne 0 ]; then
        mpdscribble &
        fi

    	exec awesome
        ;;
openbox)
	    openbox-session
	    ;;
kde)
        startkde
        ;;
gnome)
        awesome
        ;;
*)
        export DE=gnome &
        setxkbmap lv -variant tilde &
        dropboxd &
        #xrandr --screen 0 -s 1680x1050 &
        xrandr --auto --output DVI-I-1 &
        xrandr --auto --output DVI-I-2 --left-of DVI-I-1 &
        xrandr --auto --output DVI-I-1 &

        pidof mpdscribble >& /dev/null
        if [ $? -ne 0 ]; then
        mpdscribble &
        fi

    	exec ck-launch-session dbus-launch awesome 
	;;
esac
