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
