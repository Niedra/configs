# colored prompt
  B="\e[1;34m"
  R="\e[0;31m"
  G="\e[0;32m"
  O="\e[0;35m"
  Y="\e[0;33m"
  W="\e[0;32m"


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
alias youtube-dl='youtube-dl -dtc'
alias update='sudo pacman -Syu'
