if [ -f /etc/bashrc ]; then
    . /etc/bashrc

fi
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

NORMAL="\[\033[0m\]"
B_YELLOW="\[\033[1;33m\]"
B_GREY="\[\033[1;37m\]"
B_GREEN="\[\033[1;32m\]"
B_RED="\[\033[1;31m\]"
B_BLUE="\[\033[1;36m\]"
L_BLUE="\[\033[0;36m\]"

PATH=$HOME"/bin"
PATH=$PATH:"/bin"
PATH=$PATH":/sbin"
PATH=$PATH":/usr/bin"
PATH=$PATH":/usr/sbin"
PATH=$PATH":/usr/local/bin"
PATH=$PATH":/usr/local/sbin"
PATH=$PATH":~/.gem/ruby/1.9.1/bin"
PATH=$PATH":~/.gem/ruby/2.0.0/bin"
PATH=$PATH":/usr/bin/core_perl"
PATH=$PATH":/opt/pyshell/bin"

export PATH
export MANPAGER="/usr/bin/most -s"
export LANG=en_US.UTF-8
export EDITOR=vim

alias rm='rm -rf'
alias ls='ls --color'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -Al'
alias mkdir='mkdir -p'
alias df='df -kTh'
alias fn='find . ! -name "*.svn*" -name'
alias a='ack -a'
alias dig='dig +nocmd +noques'
alias diff='colordiff'
alias vd='vimdiff'
alias ..="cd .."
alias ssh-x='ssh -c arcfour -XC'
alias gt='git'
alias q="exit"
bind '"\C-o":"\C-u ranger\C-m"'
bind '"\C-p":"\C-u ncmpc\C-m"'


shopt -s cdspell
export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
export CSCOPE_DB=/home/fta/cscope/oam/cscope.out
if [ -e $PYSHELL_ROOT ]; then
    export PYSHELL_DEBUG=0
    export PYSHELL_ROOT=/opt/pyshell
    export PYTHONPATH=$PYTHONPATH:"/opt/pyshell/lib"
    export SYNC_HOME=~/Dropbox/
fi

PS1="$B_YELLOW\u$B_GREY@$B_GREEN\h$B_BLUE: $B_RED\w$B_BLUE \n$B_BLUE($B_RED\t$B_YELLOW[$SHLVL]$B_BLUE)\$ $NORMAL"
case `cat /etc/issue` in
    Ubuntu*)
        source /usr/share/autojump/autojump.bash;;
    Arch*)
        if [[ -f /usr/etc/profile.d/autojump.bash ]]; then
            source /usr/etc/profile.d/autojump.bash
        elif [[ -f /etc/profile.d/autojump.bash ]]; then
            source /etc/profile.d/autojump.bash
        fi;;
    *);;
esac
if [[ -f $HOME/.bash_completion ]]; then
    source ~/.bash_completion
fi
ulimit -c unlimited
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
    bind '"\C-x\C-m": set-mark'
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
