# colored prompt
  B="\e[1;34m"
  R="\e[0;31m"
  G="\e[0;32m"
  O="\e[0;35m"
  Y="\e[0;33m"
  W="\e[0;37m"

if [ -n "$DISPLAY" ]; then
     BROWSER=chromium
fi

if [ '/usr/bin/whoami' = root ]
then
    export PS1="\[$B\][ \[$Y\]\A \[$B\]][ \[$G\]\h:\w \[$B\]]\[$Y\] ─\[$Y\]> \[$W\]"
fi
PS1="\[$B\][ \[$Y\]\A \[$B\]][ \[$O\]\h:\w \[$B\]]\[$Y\] » \[$W\]"

alias ls='ls -hF --color --group-directories-first'
alias svnup='svn update /srv/http/'

alias mv='mv -v'
alias cp='cp -v'
alias unrarx='unrar x *.rar'
alias df='df -h'
alias plowdown='plowdown -o /media/150/rs/'
alias startmobile='sudo odccm && sync-engine -d'
alias umountshare='sudo umount.cifs ~/share/'
alias mountshare='sudo mount -t cifs //192.168.2.102/share share/ -o username=Ni,password=p0k3m0n1 -v'
alias youtube-dl='youtube-dl -tc '
alias update='sudo pacman -Syu'
alias arch32='sudo /etc/rc.d/arch32 start && sudo xhost +local: && sudo chroot /opt/arch32'

alias startnethack='urxvt -fn "xft:Envy Code R:pixelsize=18" -e nethack'
alias cpp-up='unison -auto cpp'

gcco() {
    local IN=$*;
    local OUT=${IN%.c};
    echo "Compilling $IN into $OUT";
    
    gcc -o $OUT $IN;
}
