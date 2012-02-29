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
alias du='du -h -c'
alias plowdown='plowdown -o /media/150/rs/'
alias startmobile='sudo odccm && sync-engine -d'
alias umountshare='sudo umount.cifs ~/share/'
alias mountshare='sudo mount -t cifs //192.168.2.102/share share/ -o username=Ni,password=p0k3m0n1 -v'
alias youtube-dl='youtube-dl -c -f 22 -t'
alias update='sudo pacman -Syu'
alias arch32='sudo /etc/rc.d/arch32 start && sudo xhost +local: && sudo chroot /opt/arch32'
alias lamp='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
alias gr='grep -iR $1 */*.{cpp,h,cc}'

alias cdcpp='cd ~/workspace/cpp'
alias cdadv='cd /srv/http/advice/'

alias startnethack='urxvt -fn "xft:Envy Code R:pixelsize=18" -e nethack'
alias cpp-up='unison -auto cpp'

alias ga='git add'
alias gp='git push'
alias gl='git log --pretty=format:"%Cgreen%h %Creset %s %Cblueby %an (%ar) %Cred %d" --graph'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit'
alias gma='git commit -a'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'

alias halt='sudo halt'
alias reboot='sudo reboot'

gcco() {
    local IN=$*;
    local OUT=${IN%.c};
    echo "Compilling $IN into $OUT";
    
    gcc -o $OUT $IN;
}

restart_mod() {
    local IN=$*;
    
    sudo /etc/rc.d/${IN} restart
}

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
	test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
	. "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi
