xsetroot -cursor_name left_ptr

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
        #ck-launch-session awesome &
	    glipper-old &
#        trayer --edge top --align right --heighttype pixel --height 15 --SetDockType false --widthtype pixel --width 350 --margin 207 --tint 0x1c1c1c --transparent true --alpha 0 &
	    setxkbmap lv -variant tilde &
        dropboxd &
    	exec awesome
	;;
esac
