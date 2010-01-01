# colored prompt
  B="\e[0;34m"
  R="\e[1;31m"
  G="\e[0;32m"
  Y="\e[0;33m"

W="\e[0m"
if [ '/usr/bin/whoami' = root ]
then
    export PS1="\[$Y\]┌─\[$W\][ \[$Y\]\A \[$W\]][ \[$R\]\h:\w \[$W\]]\n\[$B\]└─\[$Y\]> \[$W\]"
else
    export PS1="\[$B\]┌─\[$W\][ \[$Y\]\A \[$W\]][ \[$G\]\h:\w \[$W\]]\n\[$B\]└─\[$Y\]> \[$W\]"
fi
PS1="\[$B\]┌─\[$W\][ \[$Y\]\A \[$W\]][ \[$G\]\h:\w \[$W\]]\n\[$B\]└─\[$Y\]> \[$W\]"
alias ls='ls -hF --color'
alias svnup='svn update /srv/http/'
