# NOTE: slim runs ck-launch-session & other jazz
xsetroot -cursor_name left_ptr

source /etc/X11/xinit/xinitrc.d/30-dbus

case $1 in
awesome) # default
        nm-applet --sm-disable &
        pnmixer &
        setxkbmap lv -variant tilde &
        dropboxd &
        #xrandr --screen 0 -s 1680x1050 &
        #xrandr --auto --output DVI-I-1 &
        #xrandr --auto --output DVI-I-2 --left-of DVI-I-1 &
        #xrandr --auto --output DVI-I-1 &

        pidof mpdscribble >& /dev/null
        if [ $? -ne 0 ]; then
        mpdscribble &
        fi

    	exec ck-launch-session ssh-agent awesome
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

    	exec awesome
	;;
esac
