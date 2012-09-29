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

if [ `/usr/bin/whoami` == root ]
then
    PS1="\[$R\][ \[$Y\]\A \[$R\]][ \[$O\]\h:\w \[$R\]]\[$Y\] » \[$W\]"
else
    PS1="\[$B\][ \[$Y\]\A \[$B\]][ \[$O\]\h:\w \[$B\]]\[$Y\] » \[$W\]"
fi

alias ls='ls -hF --color --group-directories-first'
alias svnup='svn update /srv/http/'

alias mv='mv -vi'
alias cp='cp -v'
alias unrarx='unrar x *.rar'
alias df='df -h'
alias du='du -h -c'
alias update='sudo pacman -Syu'
alias arch32='sudo /etc/rc.d/arch32 start && sudo xhost +local: && sudo chroot /opt/arch32'
alias lamp='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
alias gr='grep -iR $1 */*.{cpp,h}'
alias psgrep='ps auxf|grep $1'
alias grep='grep --color -n'
alias findn='find . -name $1'
alias make='make -j 6'

alias cdcpp='cd ~/workspace/cpp'
alias cdadv='cd /srv/http/advice/'
alias cdglw='cd ~/workspace/opengl/glwiki/'

alias android-connect='go-mtpfs ~/Android'
alias android-disconnect='fusermount -u ~/Android'

cpp2asm() {
    g++ -c -g -Wa,-a,-ad $1 > $2
}

alias ga='git add'
alias gp='git push'
alias gl='git log --pretty=format:"%Cgreen%h %Creset %s %Cblueby %an (%ai) %Cred %d" --graph'
alias glm='gl --author rob'
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
alias gg='git grep -n -p --color'
alias gst='git stash'

alias halt='sudo halt'
alias reboot='sudo reboot'

restart_mod() {
    local IN=$*;
    
    sudo /etc/rc.d/${IN} restart
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
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

#PATH=/home/roberts/scripts/:$PATH
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

# TinyOS
# source /opt/tinyos-2.1.2/tinyos.sh
CLASSPATH="/opt/tinyos-2.1.2/support/sdk/java/tinyos.jar:$CLASSPATH"
