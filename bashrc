if [ -f /etc/bashrc ]; then
    . /etc/bashrc

fi
NORMAL="\[\033[0m\]"
B_YELLOW="\[\033[1;33m\]"
B_GREY="\[\033[1;37m\]"
B_GREEN="\[\033[1;32m\]"
B_RED="\[\033[1;31m\]"
B_BLUE="\[\033[1;36m\]"
PS1="$B_YELLOW\u$B_GREY@$B_GREEN\h$B_BLUE:[$B_RED\w$B_BLUE] \n$B_BLUE[$B_RED\t$B_BLUE]\$ $NORMAL"
#PS1="$B_YELLOW\u$B_GREY@$B_GREEN\h$B_BLUE:[$B_RED\w$B_BLUE] \$ $NORMAL"

export NODE_PATH=$HOME"/node_modules"
export ANT_HOME=/usr/share/java/apache-ant

PATH=$HOME"/bin"
PATH=$PATH":/usr/local/bin"
PATH=$PATH":/usr/local/sbin"
PATH=$PATH":/usr/sbin"
PATH=$PATH":/usr/bin"
PATH=$PATH":/sbin"
PATH=$PATH":/bin"
PATH=$PATH":~/.gem/ruby/1.9.1/bin"
PATH=$PATH:$ANT_HOME/bin
export PATH

export MANPAGER="/usr/bin/most -s"
export LANG=en_US.UTF-8
export EDITOR=vim

alias rr='ranger'
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


shopt -s cdspell
export GREP_OPTIONS='--color=auto' GREP_COLOR='0;35'
export CSCOPE_DB=/home/fta/cscope/oam/cscope.out
case `cat /etc/issue` in
    Ubuntu*)
        source /usr/share/autojump/autojump.bash;;
    Arch*)
        source /etc/profile.d/autojump.bash;;
    *);;
esac
