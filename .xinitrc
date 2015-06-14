# NOTE: slim runs ck-launch-session & other jazz
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export BROWSER=/usr/bin/chromium

#xsetroot -cursor_name left_ptr

case $1 in
awesome) # default
        nm-applet --sm-disable &
        pnmixer &
        setxkbmap lv -variant tilde &
        dropbox &
        #xrandr --screen 0 -s 1680x1050 &
        #xrandr --auto --output DVI-I-1 &
        #xrandr --auto --output DVI-I-2 --left-of DVI-I-1 &
        #xrandr --auto --output DVI-I-1 &

        pidof mpdscribble >& /dev/null
        if [ $? -ne 0 ]; then
        mpdscribble &
        fi

    	exec ssh-agent awesome
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
        dropbox &
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
