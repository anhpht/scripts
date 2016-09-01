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

PATH=$HOME/bin
PATH=$PATH:/bin
PATH=$PATH:/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:~/.gem/ruby/1.9.1/bin
PATH=$PATH:~/.gem/ruby/2.0.0/bin
PATH=$PATH:/usr/bin/core_perl
PATH=$PATH:/opt/pyshell/bin
PATH=$PATH:/opt/android-ndk
export PATH

# Less Colors for Man Pages
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_us=$'\e[01;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_mr=$'\e[01;35m'
export LESS_TERMCAP_me=$'\e[00m'
export LESS_TERMCAP_ue=$'\e[00m'
export LESS_TERMCAP_se=$'\e[00m'
#export MANPAGER="/usr/bin/most -s"
export MANPAGER=less

export XDG_CACHE_HOME="/run/shm/.cache"
export LANG=en_US.UTF-8
export EDITOR=vim
export SHELL=/bin/bash

#export OUT_DIR_COMMON_BASE=/mnt/data/dev/rk3188/build
export JAVA_HOME=/usr/lib/jvm/default-runtime
#export USE_CCACHE=1
#export CCACHE_DIR=/mnt/data/build_cache

alias a='ack'
alias rm='rm -rf'
alias ranger='~/.local/bin/ranger'
alias ls='ls --color'
alias l='ls -l --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias mkdir='mkdir -p'
alias df='df -kTh'
alias fn='find . ! -name "*.svn*" -name'
alias dig='dig +nocmd +noques'
alias diff='colordiff'
alias vd='vimdiff'
alias ..="cd .."
#alias ssh-x='ssh -c arcfour -XC'
alias gt='git'
alias q="exit"
#alias grep="grep --color=auto GREP_COLOR='0;35'"
alias sy="JAVA_HOME=/usr/lib/jvm/java-8-jdk/jre;sy"
#bind '"\C-o":"\C-u ranger\C-m"'
#bind '"\C-m":"\C-u mutt\C-m"'
bind '"\C-n":"\C-u ncmpc\C-m"'


shopt -s cdspell
#export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
if [ -e $PYSHELL_ROOT ]; then
    export PYSHELL_DEBUG=0
    export PYSHELL_ROOT=/opt/pyshell
    export PYTHONPATH=$PYTHONPATH:"/opt/pyshell/lib"
    export SYNC_HOME=~/Dropbox/
fi

PS1="$B_YELLOW\u$B_GREY@$B_GREEN\h$B_BLUE: $B_RED\w$B_BLUE \n$B_BLUE($B_RED\t$B_YELLOW[$SHLVL]$B_BLUE)\$ $NORMAL"
if [[ -f /usr/etc/profile.d/autojump.bash ]]; then
    source /usr/etc/profile.d/autojump.bash
elif [[ -f /etc/profile.d/autojump.bash ]]; then
    source /etc/profile.d/autojump.bash
fi

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
CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/lib/z.sh
